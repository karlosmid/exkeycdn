defmodule ExKeyCDN.ZoneTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "list/0" do
    test "mock" do
      expected = [
        zones: [%ExKeyCDN.Zone{}, %ExKeyCDN.Zone{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:list, fn -> expected end)

      assert zone().list() == expected
    end

    test "mock http and empty ok" do
      expected = [
        zones: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "just some nice text."},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.list() == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones.json", %{} -> expected end)

      assert ExKeyCDN.Zone.list() == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.list() == expected
    end
  end

  describe "view/1" do
    test "mock" do
      expected = [
        zone: %ExKeyCDN.Zone{},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:view, fn 1 -> expected end)

      assert zone().view(1) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: %ExKeyCDN.Zone{name: "test"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{"zone" => %{"name" => "test"}},
           "status" => "success",
           "description" => "just some nice text."
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.view(1) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/1.json", %{} -> expected end)

      assert ExKeyCDN.Zone.view(1) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.view(1) == expected
    end
  end

  describe "add/1" do
    test "mock" do
      zone = %ExKeyCDN.Zone{name: "third"}

      expected = [
        zone: zone,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:add, fn _zone -> expected end)

      assert zone().add(zone) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: %ExKeyCDN.Zone{name: "test"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{"zone" => %{"name" => "test"}},
           "status" => "success",
           "description" => "just some nice text."
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      zone_add = Map.from_struct(%ExKeyCDN.Zone{name: "test"})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zones.json", ^zone_add -> mocked end)

      assert ExKeyCDN.Zone.add(%ExKeyCDN.Zone{name: "test"}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zones.json", %{} -> expected end)

      assert ExKeyCDN.Zone.add(%ExKeyCDN.Zone{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :post, "zones.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.add(%ExKeyCDN.Zone{}) == expected
    end
  end

  describe "edit/2" do
    test "mock" do
      zone = %ExKeyCDN.Zone{name: "third_update"}
      param = %{name: "third_update"}

      expected = [
        zone: zone,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:edit, fn 1, _param -> expected end)

      assert zone().edit(1, param) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: %ExKeyCDN.Zone{name: "test"},
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok,
         %{
           "data" => %{"zone" => %{"name" => "test"}},
           "status" => "success",
           "description" => "just some nice text."
         }, [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zones/1.json", %{name: "test"} -> mocked end)

      assert ExKeyCDN.Zone.edit(1, %{name: "test"}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zones/1.json", %{} -> expected end)

      assert ExKeyCDN.Zone.edit(1, %ExKeyCDN.Zone{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :put, "zones/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.edit(1, %ExKeyCDN.Zone{}) == expected
    end
  end

  describe "delete/1" do
    test "mock" do
      expected = [
        zone: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:delete, fn 1 -> expected end)

      assert zone().delete(1) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: :deleted,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.delete(1) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/1.json", %{} -> expected end)

      assert ExKeyCDN.Zone.delete(1) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.delete(1) == expected
    end
  end

  describe "purge_cache/1" do
    test "mock" do
      expected = [
        zone: :cache_purged,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:purge_cache, fn 1 -> expected end)

      assert zone().purge_cache(1) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: :cache_purged,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/purge/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.purge_cache(1) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/purge/1.json", %{} -> expected end)

      assert ExKeyCDN.Zone.purge_cache(1) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "zones/purge/1.json", %{} -> mocked end)

      assert ExKeyCDN.Zone.purge_cache(1) == expected
    end
  end

  describe "purge_url/2" do
    test "mock" do
      expected = [
        zone: :url_purged,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      ExKeyCDN.MockZone
      |> expect(:purge_url, fn 1, ["a.css", "b.html"] -> expected end)

      assert zone().purge_url(1, ["a.css", "b.html"]) == expected
    end

    test "mock http and ok" do
      expected = [
        zone: :url_purged,
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/purgeurl/1.json", %{urls: ["a", "b"]} -> mocked end)

      assert ExKeyCDN.Zone.purge_url(1, ["a", "b"]) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/purgeurl/1.json", %{urls: ["a", "b"]} -> expected end)

      assert ExKeyCDN.Zone.purge_url(1, ["a", "b"]) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :delete, "zones/purgeurl/1.json", %{urls: ["a", "b"]} -> mocked end)

      assert ExKeyCDN.Zone.purge_url(1, ["a", "b"]) == expected
    end
  end

  defp zone do
    Application.get_env(:exkeycdn, :zone)
  end
end
