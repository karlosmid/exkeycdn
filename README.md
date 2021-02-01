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

## API Key

`export api_key="value"`

## Usage


```elixir
ExKeyCDN.Zone.list

[
  zones: [
    %ExKeyCDN.Zone{
      cachehostheader: "disabled",
      forcessl: "disabled",
      name: "examplepull",
      type: "push",
      expire: "0",
      cachemaxexpire: 1440,
      originurl: "url of max 128 characters",
      cachekeycookie: "alphanumeric 32 charachters",
      originshield: "disabled",
      cachexpullkey: "ExKeyCDN",
      cacheignorequerystring: "enabled",
      cachekeydevice: "disabled",
      allowemptyreferrer: "enabled", 
      sslcert: "shared",
      cachekeyhost: "disabled",
      cacheerrorpages: "disabled",
      status: "active",
      cachekeywebp: "disabled",
      cachekeyscheme: "disabled",
      blockreferrer: "disabled",
      securetokenkey: nil,
      customsslkey: nil,
      forcedownload: "disabled",
      gzip: "disabled",
      securetoken: "disabled",
      cachestripcookies: "disabled",
      id: "190392",
      blockbadbots: "disabled",
      cachecanonical: "disabled",
      imgproc: "disabled",
      customsslcert: nil, 
      dirlistt: "disabled",
      cors: "disabled",
      cachebr: "disabled",
      cacheignorecachecontrol: "enabled",
      cachecookies: "disabled",
      cacherobots: "disabled"
    },
    %ExKeyCDN.Zone{
      cachehostheader: "disabled",
      forcessl: "disabled",
      name: "karlo",
      type: "push",
      expire: "0",
      cachemaxexpire: 1440,
      originurl: "url of max 128 characters",
      cachekeycookie: "alphanumeric 32 charachters",
      originshield: "disabled",
      cachexpullkey: "ExKeyCDN",
      cacheignorequerystring: "enabled",
      cachekeydevice: "disabled",
      allowemptyreferrer: "enabled",
      sslcert: "shared",
      cachekeyhost: "disabled",
      cacheerrorpages: "disabled",
      status: "active",
      cachekeywebp: "disabled",
      cachekeyscheme: "disabled", 
      blockreferrer: "disabled",
      securetokenkey: nil,
      customsslkey: nil,
      forcedownload: "disabled",
      gzip: "disabled",
      securetoken: "disabled",
      cachestripcookies: "disabled",
      id: "190395",
      blockbadbots: "disabled",
      cachecanonical: "disabled",
      imgproc: "disabled",
      customsslcert: nil,
      dirlistt: "disabled",
      cors: "disabled",
      cachebr: "disabled",
      cacheignorecachecontrol: "enabled",
      cachecookies: "disabled",
      cacherobots: "disabled"
    }
  ],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
ExKeyCDN.Zone.view 190395
[
  zones: %ExKeyCDN.Zone{
    cachehostheader: "disabled",
    forcessl: "disabled",
    name: "karlo",
    type: "push",
    expire: "0",
    cachemaxexpire: 1440,
    originurl: "url of max 128 characters",
    cachekeycookie: "alphanumeric 32 charachters",
    originshield: "disabled",
    cachexpullkey: "ExKeyCDN",
    cacheignorequerystring: "enabled",
    cachekeydevice: "disabled",
    allowemptyreferrer: "enabled",
    sslcert: "shared",
    cachekeyhost: "disabled",
    cacheerrorpages: "disabled",
    status: "active",
    cachekeywebp: "disabled",
    cachekeyscheme: "disabled",
    blockreferrer: "disabled",
    securetokenkey: nil,
    customsslkey: nil,
    forcedownload: "disabled",
    gzip: "disabled",
    securetoken: "disabled",
    cachestripcookies: "disabled",
    id: "190395",
    blockbadbots: "disabled",
    cachecanonical: "disabled",
    imgproc: "disabled",
    customsslcert: nil,
    dirlistt: "disabled",
    cors: "disabled",
    cachebr: "disabled",
    cacheignorecachecontrol: "enabled",
    cachecookies: "disabled",
    cacherobots: "disabled"
  },
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

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

