defmodule ExKeyCDN.ZoneAliasTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "list/0" do
    test "mock" do
      expected = [
        zone_aliases: [%ExKeyCDN.ZoneAlias{}, %ExKeyCDN.ZoneAlias{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneAlias
      |> expect(:list, fn -> expected end)

      assert zone_alias().list() == expected
    end

    test "mock http and ok" do
      expected = [
        zone_aliases: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonealiases.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.list() == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonealiases.json", %{} -> expected end)

      assert ExKeyCDN.ZoneAlias.list() == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonealiases.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.list() == expected
    end
  end

  describe "add/1" do
    test "mock" do
      zone_alias = %ExKeyCDN.ZoneAlias{name: "third"}

      expected = [
        zone_alias: zone_alias,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneAlias
      |> expect(:add, fn _zone_alias -> expected end)

      assert zone_alias().add(zone_alias) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_alias: %ExKeyCDN.ZoneAlias{id: "119523", name: "google.hr", zone_id: "190976"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{
             "zonealias" => %{"id" => "119523", "name" => "google.hr", "zone_id" => "190976"}
           },
           "status" => "success",
           "description" => "good work"
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post,
                             "zonealiases.json",
                             %{id: nil, name: "google.hr", zone_id: 190_976} ->
        mocked
      end)

      assert ExKeyCDN.ZoneAlias.add(%ExKeyCDN.ZoneAlias{zone_id: 190_976, name: "google.hr"}) ==
               expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zonealiases.json", %{} -> expected end)

      assert ExKeyCDN.ZoneAlias.add(%ExKeyCDN.ZoneAlias{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zonealiases.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.add(%ExKeyCDN.ZoneAlias{}) == expected
    end
  end

  describe "edit/2" do
    test "mock" do
      zone_alias = %ExKeyCDN.ZoneAlias{name: "third_update"}
      param = %{name: "third_update"}

      expected = [
        zone_alias: zone_alias,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneAlias
      |> expect(:edit, fn 1, _param -> expected end)

      assert zone_alias().edit(1, param) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_alias: %ExKeyCDN.ZoneAlias{id: "119523", name: "google.hr", zone_id: "190976"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{
             "zonealias" => %{"id" => "119523", "name" => "google.hr", "zone_id" => "190976"}
           },
           "status" => "success",
           "description" => "good work"
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put,
                             "zonealiases/119523.json",
                             %{name: "google.hr", zone_id: 190_976} ->
        mocked
      end)

      assert ExKeyCDN.ZoneAlias.edit(119_523, %{zone_id: 190_976, name: "google.hr"}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zonealiases/1.json", %{} -> expected end)

      assert ExKeyCDN.ZoneAlias.edit(1, %{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zonealiases/1.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.edit(1, %{}) == expected
    end
  end

  describe "delete" do
    test "mock" do
      expected = [
        zone_alias: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneAlias
      |> expect(:delete, fn 1 -> expected end)

      assert zone_alias().delete(1) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_alias: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonealiases/119523.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.delete(119_523) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonealiases/1.json", %{} -> expected end)

      assert ExKeyCDN.ZoneAlias.delete(1) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonealiases/1.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneAlias.delete(1) == expected
    end
  end

  defp zone_alias do
    Application.get_env(:exkeycdn, :zone_alias)
  end
end
