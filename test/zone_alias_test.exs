defmodule ExKeyCDN.ZoneAliasTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "List" do
    expected = [
      zone_aliases: [%ExKeyCDN.ZoneAlias{}, %ExKeyCDN.ZoneAlias{}],
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZoneAlias
    |> expect(:list, fn -> expected end)

    assert zone_alias().list() == expected
  end

  test "add" do
    zone_alias = %ExKeyCDN.ZoneAlias{name: "third"}

    expected = [
      zone_alias: zone_alias,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZoneAlias
    |> expect(:add, fn _zone_alias -> expected end)

    assert zone_alias().add(zone_alias) == expected
  end

  test "edit" do
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

  test "delete" do
    expected = [
      zone_alias: :deleted,
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZoneAlias
    |> expect(:delete, fn 1 -> expected end)

    assert zone_alias().delete(1) == expected
  end

  defp zone_alias do
    Application.get_env(:exkeycdn, :zone_alias)
  end
end
