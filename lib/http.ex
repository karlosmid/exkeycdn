defmodule ExKeyCDN.HTTP do
  @moduledoc """
  Base client for all server interaction, used by all endpoint specific
  modules.

  This request wrapper coordinates the remote server, headers, authorization
  and SSL options.

  Using `ExKeyCDN.HTTP` requires the presence of one config value:

  * `api_key` - ExKeyCDN api key

  Value must be set or a `ExKeyCDN.ConfigError` will be raised at
  runtime. All those config values support the `{:system, "VAR_NAME"}` as a
  value - in which case the value will be read from the system environment with
  `System.get_env("VAR_NAME")`.
  """

  require Logger

  alias ExKeyCDN.ErrorResponse, as: Error
  alias ExKeyCDN.{Decoder, Encoder}

  @type response ::
          {:ok, map, list | {:error, atom}}
          | {:error, Error.t()}
          | {:error, binary}

  @headers [
    {"Accept", "application/json"},
    {"User-Agent", "ExKeyCDN Elixir/0.1"},
    {"X-ApiVersion", "1"},
    {"Content-Type", "application/x-www-form-urlencoded"}
  ]

  @statuses %{
    200 => :ok,
    400 => :bad_request,
    401 => :unauthorized,
    403 => :forbidden,
    404 => :not_found,
    413 => :request_entity_too_large,
    429 => :too_many_requests,
    451 => :illegal,
    500 => :server_error,
    502 => :bad_gateway,
    503 => :service_unavailable,
    504 => :connect_timeout
  }

  @doc """
  Centralized request handling function. All convenience structs use this
  function to interact with the ExKeyCDN servers. This function can be used
  directly to supplement missing functionality.

  ## Example

      defmodule MyApp.ExKeyCDN do
        alias ExKeyCDN.HTTP

        def zones(params \\ %{}) do
          HTTP.request(:get, "zones.json", params)
        end
      end
  """
  @spec request(atom, binary, binary | map) :: response
  def request(method, path, body \\ %{}) do
    emit_start(method, path)

    start_time = System.monotonic_time()

    try do
      case method do
        :get ->
          :hackney.request(
            method,
            build_url(path, body),
            build_headers(),
            encode_body(%{}),
            build_options()
          )

        _ ->
          case encode_body(body) do
            {:error, message} ->
              {:error, message}

            encoded_body ->
              :hackney.request(
                method,
                build_url(path),
                build_headers(),
                encoded_body,
                build_options()
              )
          end
      end
    catch
      kind, reason ->
        duration = System.monotonic_time() - start_time

        emit_exception(duration, method, path, %{
          kind: kind,
          reason: reason,
          stacktrace: __STACKTRACE__
        })

        :erlang.raise(kind, reason, __STACKTRACE__)
    else
      {:ok, code, headers, body} when code in 200..400 ->
        duration = System.monotonic_time() - start_time
        emit_stop(duration, method, path, code)
        {:ok, decode_body(body), headers}

      {:ok, code, headers, _body} when code in 401..504 ->
        duration = System.monotonic_time() - start_time
        emit_stop(duration, method, path, code)
        {:error, code_to_reason(code), headers}

      {:error, reason} ->
        duration = System.monotonic_time() - start_time
        emit_error(duration, method, path, reason)
        {:error, reason}
    end
  end

  for method <- ~w(get delete post put)a do
    @spec unquote(method)(binary) :: response
    @spec unquote(method)(binary, map | list) :: response
    def unquote(method)(path) do
      request(unquote(method), path, %{})
    end

    def unquote(method)(path, payload) when is_map(payload) do
      request(unquote(method), path, payload)
    end

    def unquote(method)(path, payload) do
      request(unquote(method), path, payload)
    end
  end

  ## Helper Functions

  @doc false
  @spec build_url(binary, map) :: binary
  def build_url(path, params \\ %{}) do
    url = get_lazy_env([], :url) <> "/" <> path

    case params == %{} do
      true ->
        url

      false ->
        url <> "?" <> Encoder.encode(params)
    end
  end

  @doc false
  @spec encode_body(binary | map) :: binary | {:error, binary}
  def encode_body(body) when body == "" or body == %{}, do: ""
  def encode_body(body), do: Encoder.encode(body)

  @doc false
  @spec decode_body(binary) :: map
  def decode_body(body) do
    body
    |> String.trim()
    |> Decoder.decode()
  rescue
    Jason.DecodeError ->
      Logger.error("unprocessable response")
      %{}
  end

  @doc false
  @spec build_headers() :: [tuple]
  def build_headers do
    auth_header = "Basic " <> :base64.encode(get_lazy_env([], :api_key) <> ":")

    [{"Authorization", auth_header} | @headers]
  end

  def get_lazy_env(opts, key, default \\ nil) do
    Keyword.get_lazy(opts, key, fn -> ExKeyCDN.get_env(key, default) end)
  end

  @doc false
  @spec build_options() :: [...]
  def build_options do
    http_opts = ExKeyCDN.get_env(:http_options, [])
    [:with_body] ++ http_opts
  end

  @doc false
  @spec code_to_reason(integer) :: atom
  def code_to_reason(integer)

  for {code, status} <- @statuses do
    def code_to_reason(unquote(code)), do: unquote(status)
  end

  defp emit_start(method, path) do
    :telemetry.execute(
      [:exkeycdn, :request, :start],
      %{system_time: System.system_time()},
      %{method: method, path: path}
    )
  end

  defp emit_exception(duration, method, path, error_data) do
    :telemetry.execute(
      [:exkeycdn, :request, :exception],
      %{duration: duration},
      %{method: method, path: path, error: error_data}
    )
  end

  defp emit_error(duration, method, path, error_reason) do
    :telemetry.execute(
      [:exkeycdn, :request, :error],
      %{duration: duration},
      %{method: method, path: path, error: error_reason}
    )
  end

  defp emit_stop(duration, method, path, code) do
    :telemetry.execute(
      [:exkeycdn, :request, :stop],
      %{duration: duration},
      %{method: method, path: path, http_status: code}
    )
  end
end
