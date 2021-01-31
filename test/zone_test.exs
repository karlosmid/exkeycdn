defmodule KeyCDN.ZoneTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "ListZones" do
    expected = [
      zones: [%KeyCDN.Zone{}, %KeyCDN.Zone{}],
      limits: [rate_limit_remaining: "60", rate_limit: "60"]
    ]

    KeyCDN.MockZone
    |> expect(:list_zones, fn -> expected end)

    assert zone().list_zones() == expected
  end

  defp zone do
    Application.get_env(:keycdn, :zone)
  end
end
