defmodule ExKeyCDN.HTTPTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureLog

  alias ExKeyCDN.{ConfigError, HTTP}

  test "build_url/2 builds a url from application config without params" do
    assert HTTP.build_url("zones.json") =~
             "zones.json"
  end

  test "build_url/2 builds a url with params" do
    assert HTTP.build_url("zones.json", %{name: "big name", second: "is second"}) =~
             "zones.json?name=big+name&second=is+second"
  end

  test "encode_body/1 converts the request body to xml" do
    params = %{company: "Soren", first_name: "Parker"}

    assert HTTP.encode_body(params, :form) ==
             ~s|company=Soren&first_name=Parker|
  end

  test "encode_body/1 ignores empty bodies" do
    assert HTTP.encode_body("", :form) == ""
    assert HTTP.encode_body(%{}, :json) == ""
  end

  test "decode_body/1 converts json to map" do
    body = %{company: "Soren", first_name: "Parker"}

    assert HTTP.decode_body(Jason.encode!(body)) == %{
             "company" => "Soren",
             "first_name" => "Parker"
           }
  end

  test "decode_body/1 safely handles empty responses" do
    assert HTTP.decode_body("") == %{}
    assert HTTP.decode_body(" ") == %{}
  end

  test "decode_body/1 logs unhandled errors" do
    assert capture_log(fn ->
             HTTP.decode_body("asdf")
           end) =~ "unprocessable response"
  end

  test "build_options/0 considers the application environment" do
    with_applicaton_config(:http_options, [timeout: 9000], fn ->
      options = HTTP.build_options()

      assert :with_body in options
      assert {:timeout, 9000} in options
    end)
  end

  describe "request/3" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "unauthorized response", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "zones.json", fn conn ->
        Plug.Conn.resp(conn, 401, ~s<"Unauthorized">)
      end)

      with_applicaton_config(:url, "http://localhost:#{bypass.port}", fn ->
        with_applicaton_config(:api_key, "wrong key", fn ->
          assert {:error, :unauthorized} = HTTP.request(:get, "zones.json")
        end)
      end)
    end
  end

  describe "telemetry events from request" do
    setup do
      bypass = Bypass.open()

      on_exit(fn ->
        :telemetry.list_handlers([])
        |> Enum.each(&:telemetry.detach(&1.id))
      end)

      {:ok, bypass: bypass}
    end

    test "emits a start and stop message on a successful request", %{
      bypass: bypass
    } do
      Bypass.expect_once(bypass, "GET", "zones.json", fn conn ->
        Plug.Conn.resp(conn, 200, "ok")
      end)

      :telemetry.attach("start event", [:exkeycdn, :request, :start], &echo_event/4, %{
        caller: self()
      })

      :telemetry.attach("stop event", [:exkeycdn, :request, :stop], &echo_event/4, %{
        caller: self()
      })

      with_applicaton_config(:url, "http://localhost:#{bypass.port}", fn ->
        with_applicaton_config(:api_key, "wrong key", fn ->
          HTTP.request(:get, "zones.json", %{})
        end)
      end)

      assert_receive {:event, [:exkeycdn, :request, :start], %{system_time: _time},
                      %{method: :get, path: "zones.json"}}

      assert_receive {:event, [:exkeycdn, :request, :stop], %{duration: _time},
                      %{method: :get, path: "zones.json", http_status: _code}}
    end
  end

  describe "build_headers/1" do
    test "building an auth header from application config" do
      with_applicaton_config(:api_key, "the_private_key", fn ->
        {_, auth_header} = List.keyfind(HTTP.build_headers(), "Authorization", 0)

        assert auth_header == "Basic dGhlX3ByaXZhdGVfa2V5Og=="
      end)
    end

    test "build_headers/1 raises a helpful error message without config" do
      assert_config_error(:api_key, fn ->
        HTTP.build_headers()
      end)
    end
  end

  defp assert_config_error(key, fun) do
    assert_raise ConfigError, "missing config for :#{key}", fun
  end

  defp with_applicaton_config(key, value, fun) do
    original = ExKeyCDN.get_env(key, :none)

    try do
      ExKeyCDN.put_env(key, value)
      fun.()
    after
      case original do
        :none -> Application.delete_env(:exkeycdn, key)
        _ -> ExKeyCDN.put_env(key, original)
      end
    end
  end

  def echo_event(event, measurements, metadata, config) do
    send(config.caller, {:event, event, measurements, metadata})
  end
end
