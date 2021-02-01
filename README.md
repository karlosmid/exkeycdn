# ExExKeyCDN

Elixir client for https://www.ExKeyCDN.com/api

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exExKeyCDN` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exExKeyCDN, "~> 0.1.0"}
  ]
end
```

## Usage

## Integration Testing

Library is using behaviour which is a precondition for using Mox library. Here is example how to mock Zone list feature:

```elixir
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

  defp zone do
    Application.get_env(:exkeycdn, :zone)
  end
end
```

Add to your `test_helpers.exs`

```elixir
Mox.defmock(ExKeyCDN.MockZone, for: ExKeyCDN.ZoneBehaviour)
Application.put_env(:exkeycdn, :zone, ExKeyCDN.MockZone)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exExKeyCDN](https://hexdocs.pm/exExKeyCDN).

