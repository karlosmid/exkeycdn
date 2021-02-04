defmodule ExKeyCDN.ZoneTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "List" do
    expected = [
      zones: [%ExKeyCDN.Zone{}, %ExKeyCDN.Zone{}],
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:list, fn -> expected end)

    assert zone().list() == expected
  end

  test "view" do
    expected = [
      zone: %ExKeyCDN.Zone{},
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:view, fn 1 -> expected end)

    assert zone().view(1) == expected
  end

  test "add" do
    zone = %ExKeyCDN.Zone{name: "third"}

    expected = [
      zone: zone,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:add, fn _zone -> expected end)

    assert zone().add(zone) == expected
  end

  test "edit" do
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

  test "delete" do
    expected = [
      zone: :deleted,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:delete, fn 1 -> expected end)

    assert zone().delete(1) == expected
  end

  test "purge cache" do
    expected = [
      zone: :cache_purged,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:purge_cache, fn 1 -> expected end)

    assert zone().purge_cache(1) == expected
  end

  test "purge url" do
    expected = [
      zone: :url_purged,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:purge_url, fn 1, ["a.css", "b.html"] -> expected end)

    assert zone().purge_url(1, ["a.css", "b.html"]) == expected
  end

  defp zone do
    Application.get_env(:exkeycdn, :zone)
  end
end
