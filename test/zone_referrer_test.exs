defmodule ExKeyCDN.ZoneReferrerTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "list/0" do
    test "mock" do
      expected = [
        zone_referrers: [%ExKeyCDN.ZoneReferrer{}, %ExKeyCDN.ZoneReferrer{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneReferrer
      |> expect(:list, fn -> expected end)

      assert zone_referrer().list() == expected
    end

    test "mock http and ok" do
      expected = [
        zone_referrers: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonereferrers.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.list() == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonereferrers.json", %{} -> expected end)

      assert ExKeyCDN.ZoneReferrer.list() == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zonereferrers.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.list() == expected
    end
  end

  describe "add/1" do
    test "mock" do
      zone_referrer = %ExKeyCDN.ZoneReferrer{name: "third"}

      expected = [
        zone_referrer: zone_referrer,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneReferrer
      |> expect(:add, fn _zone_referrer -> expected end)

      assert zone_referrer().add(zone_referrer) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_referrer: %ExKeyCDN.ZoneReferrer{id: "119523", name: "google.hr", zone_id: "190976"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{
             "zonereferrer" => %{"id" => "119523", "name" => "google.hr", "zone_id" => "190976"}
           },
           "status" => "success",
           "description" => "good work"
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post,
                             "zonereferrers.json",
                             %{id: nil, name: "google.hr", zone_id: 190_976} ->
        mocked
      end)

      assert ExKeyCDN.ZoneReferrer.add(%ExKeyCDN.ZoneReferrer{zone_id: 190_976, name: "google.hr"}) ==
               expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zonereferrers.json", %{} -> expected end)

      assert ExKeyCDN.ZoneReferrer.add(%ExKeyCDN.ZoneReferrer{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zonereferrers.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.add(%ExKeyCDN.ZoneReferrer{}) == expected
    end
  end

  describe "edit/2" do
    test "mock" do
      zone_referrer = %ExKeyCDN.ZoneReferrer{name: "third_update"}
      param = %{name: "third_update"}

      expected = [
        zone_referrer: zone_referrer,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneReferrer
      |> expect(:edit, fn 1, _param -> expected end)

      assert zone_referrer().edit(1, param) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_referrer: %ExKeyCDN.ZoneReferrer{id: "119523", name: "google.hr", zone_id: "190976"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{
             "zonereferrer" => %{"id" => "119523", "name" => "google.hr", "zone_id" => "190976"}
           },
           "status" => "success",
           "description" => "good work"
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put,
                             "zonereferrers/119523.json",
                             %{name: "google.hr", zone_id: 190_976} ->
        mocked
      end)

      assert ExKeyCDN.ZoneReferrer.edit(119_523, %{zone_id: 190_976, name: "google.hr"}) ==
               expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zonereferrers/1.json", %{} -> expected end)

      assert ExKeyCDN.ZoneReferrer.edit(1, %{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zonereferrers/1.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.edit(1, %{}) == expected
    end
  end

  describe "delete" do
    test "mock" do
      expected = [
        zone_referrer: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZoneReferrer
      |> expect(:delete, fn 1 -> expected end)

      assert zone_referrer().delete(1) == expected
    end

    test "mock http and ok" do
      expected = [
        zone_referrer: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonereferrers/119523.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.delete(119_523) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonereferrers/1.json", %{} -> expected end)

      assert ExKeyCDN.ZoneReferrer.delete(1) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zonereferrers/1.json", %{} -> mocked end)

      assert ExKeyCDN.ZoneReferrer.delete(1) == expected
    end
  end

  defp zone_referrer do
    Application.get_env(:exkeycdn, :zone_referrer)
  end
end
