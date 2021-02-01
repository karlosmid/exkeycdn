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
      zones: %ExKeyCDN.Zone{},
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    ExKeyCDN.MockZone
    |> expect(:view, fn 1 -> expected end)

    assert zone().view(1) == expected
  end

  defp zone do
    Application.get_env(:ExKeyCDN, :zone)
  end
end
