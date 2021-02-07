# ExKeyCDN

Elixir client for https://www.ExKeyCDN.com/api

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exExKeyCDN` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exKeyCDN, "~> 0.1.0"}
  ]
end
```

## API Key

`export api_key="value"`

## ExKeyCDN.zone

```elixir
iex(11)> ExKeyCDN.Zone.list
[zones: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

```elixir
iex(11)> zone = %ExKeyCDN.Zone{name: "tribal", originurl: "https://blog.tentamen.eu"}
iex(11)> ExKeyCDN.Zone.add zone
[
  zone: %ExKeyCDN.Zone{
    cachekeyscheme: "disabled",
    cachebr: "disabled",
    name: "tribal",
    type: "push",
    cachecanonical: "disabled",
    forcedownload: "disabled",
    blockbadbots: "disabled",
    cachehostheader: "disabled",
    blockreferrer: "disabled",
    securetokenkey: "",
    cachemaxexpire: 1440,
    forcessl: "disabled",
    sslcert: "shared",
    originurl: "https://example.com",
    cachekeycookie: "alphanumeric32charachters",
    cacheignorequerystring: "enabled",
    status: "active",
    expire: "0",
    cacheignorecachecontrol: "enabled",
    cors: "disabled",
    cacheerrorpages: "disabled",
    cachexpullkey: "ExKeyCDN",
    cachekeywebp: "disabled",
    customsslkey: nil,
    gzip: "disabled",
    cachestripcookies: "disabled",
    cachekeydevice: "disabled",
    dirlistt: "disabled",
    cachekeyhost: "disabled",
    id: "190710",
    securetoken: "disabled",
    allowemptyreferrer: "enabled",
    imgproc: "disabled",
    originshield: "disabled",
    cacherobots: "disabled",
    cachecookies: "disabled",
    customsslcert: nil
  },
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(11)> ExKeyCDN.Zone.list
[
  zones: [
    %ExKeyCDN.Zone{
      expire: "0",
      cacheerrorpages: "disabled",
      name: "tribal",
      type: "push",
      cachekeyscheme: "disabled",
      securetoken: "disabled",
      customsslkey: nil,
      cachecanonical: "disabled",
      cachekeyhost: "disabled",
      cachekeywebp: "disabled",
      forcessl: "disabled",
      cachexpullkey: "ExKeyCDN",
      cachebr: "disabled",
      originurl: "https://example.com",
      cors: "disabled",
      cachekeydevice: "disabled",
      cachecookies: "disabled",
      status: "active",
      cacheignorequerystring: "enabled",
      originshield: "disabled",
      sslcert: "shared",
      blockreferrer: "disabled",
      imgproc: "disabled",
      gzip: "disabled",
      allowemptyreferrer: "enabled",
      dirlist: "disabled",
      cacherobots: "disabled",
      forcedownload: "disabled",
      id: "190968",
      cachehostheader: "disabled",
      cachemaxexpire: 1440,
      cachekeycookie: "alphanumeric32charachters",
      cachestripcookies: "disabled",
      securetokenkey: "",
      blockbadbots: "disabled",
      customsslcert: nil,
      cacheignorecachecontrol: "enabled"
    }
  ],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(11)> ExKeyCDN.Zone.edit(190710, %{expire: 1440})
[
  zone: %ExKeyCDN.Zone{
    cachekeyscheme: "disabled",
    cachebr: "disabled",
    name: "tribal",
    type: "push",
    cachecanonical: "disabled",
    forcedownload: "disabled",
    blockbadbots: "disabled",
    cachehostheader: "disabled",
    blockreferrer: "disabled",
    securetokenkey: "",
    cachemaxexpire: 1440,
    forcessl: "disabled",
    sslcert: "shared",
    originurl: "https://example.com",
    cachekeycookie: "alphanumeric32charachters",
    cacheignorequerystring: "enabled",
    status: "active",
    expire: "1440",
    cacheignorecachecontrol: "enabled",
    cors: "disabled",
    cacheerrorpages: "disabled",
    cachexpullkey: "ExKeyCDN",
    cachekeywebp: "disabled",
    customsslkey: nil,
    gzip: "disabled",
    cachestripcookies: "disabled",
    cachekeydevice: "disabled",
    dirlistt: "disabled",
    cachekeyhost: "disabled",
    id: "190710",
    securetoken: "disabled",
    allowemptyreferrer: "enabled",
    imgproc: "disabled",
    originshield: "disabled",
    cacherobots: "disabled",
    cachecookies: "disabled",
    customsslcert: nil
  },
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
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

```elixir
iex(11)> ExKeyCDN.Zone.delete(190710)
[zone: :deleted, limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

```elixir
iex(11)> ExKeyCDN.Zone.delete 190710
{:error, :forbidden}
```

```elixir
iex(11)> ExKeyCDN.Zone.purge_cache(190395)
#note, this action lasts > 5 sec.
[zone: :cache_purged, limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

```elixir
iex(11)> ExKeyCDN.Zone.purge_url(190395, ["a.css", "b.html"])
#note, this action lasts > 5 sec.
[zone: :url_purged, limits: [rate_limit_remaining: "59", rate_limit: "60"]]
```

## ExKeyCDN.ZoneAlias

```elixir
iex(10)> ExKeyCDN.ZoneAlias.list
[zone_aliases: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

```elixir
iex(10)> zone_alias = %ExKeyCDN.ZoneAlias{zone_id: 190976, name: "google.hr"}
%ExKeyCDN.ZoneAlias{id: nil, name: "google.hr", zone_id: 190976}
iex(10)> ExKeyCDN.ZoneAlias.add zone_alias
[
  zone_alias: %ExKeyCDN.ZoneAlias{id: "119523", name: "google.hr", zone_id: "190976"},
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneAlias.list
[
  zone_aliases: [
    %ExKeyCDN.ZoneAlias{id: "119523", name: "google.hr", zone_id: "190976"}
  ],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneAlias.edit(119523, %{zone_id: 190984, name: "google.hr"}) 
[
  zone_alias: %ExKeyCDN.ZoneAlias{
    id: "119523",
    name: "google.hr",
    zone_id: "190984"
  },
  limits: [rate_limit_remaining: "59", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneAlias.delete(119523)
[zone_alias: :deleted, limits: [rate_limit_remaining: "59", rate_limit: "60"]]
```

## ExKeyCDN.ZoneReferrer

```elixir
iex(10)> ExKeyCDN.ZoneReferrer.list
[zone_referrers: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

```elixir
iex(10)> zone_referrer = %ExKeyCDN.ZoneReferrer{zone_id: 190976, name: "google.hr"}
%ExKeyCDN.ZoneReferrer{id: nil, name: "google.hr", zone_id: 190976}
iex(10)> ExKeyCDN.ZoneReferrer.add zone_referrer
[
  zone_referrer: %ExKeyCDN.ZoneReferrer{id: "119523", name: "google.hr", zone_id: "190976"},
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneReferrer.list
[
  zone_referrers: [
    %ExKeyCDN.ZoneReferrer{id: "119523", name: "google.hr", zone_id: "190976"}
  ],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneReferrer.edit(119523, %{zone_id: 190984, name: "google.hr"}) 
[
  zone_referrer: %ExKeyCDN.ZoneReferrer{
    id: "119523",
    name: "google.hr",
    zone_id: "190984"
  },
  limits: [rate_limit_remaining: "59", rate_limit: "60"]
]
```

```elixir
iex(10)> ExKeyCDN.ZoneReferrer.delete(119523)
[zone_referrer: :deleted, limits: [rate_limit_remaining: "59", rate_limit: "60"]]
```
## Reports

### Traffic

```elixir
iex(8)> now = System.os_time(:second)
1612637843
iex(9)> start = now - 24 * 3600
1612551443
iex(10)> ExKeyCDN.Report.traffic(%ExKeyCDN.Report{zone_id: 191162, start: start, end: now})        
[stats: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
iex(11)>
```

### Storage

```elixir
iex(3)> ExKeyCDN.Report.storage(%ExKeyCDN.Report{zone_id: 191162, start: start, end: now})
[
  stats: [%ExKeyCDN.Statistic{amount: "4096", timestamp: "1612569600"}],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
iex(4)> 
```

### Image Processing

```elixir
iex(4)> ExKeyCDN.Report.image_processing(%ExKeyCDN.Report{zone_id: 191162, start: start, end: now})
[stats: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```
### Status

```elixir
iex(3)> ExKeyCDN.Report.status(%ExKeyCDN.Report{zone_id: 191162, start: start, end: now})        
[stats: [], limits: [rate_limit_remaining: "60", rate_limit: "60"]]
```

### Credit

```elixir
iex(3)> ExKeyCDN.Report.credit(%ExKeyCDN.Report{start: start, end: now})
[
  stats: [
    %ExKeyCDN.CreditStatistic{
      amount: "-0.01",
      timestamp: "1612483200",
      type: "storage"
    },
    %ExKeyCDN.CreditStatistic{
      amount: "-0.01",
      timestamp: "1612569600",
      type: "storage"
    }
  ],
  limits: [rate_limit_remaining: "60", rate_limit: "60"]
]
```

### Balance

```elixir
iex(1)> ExKeyCDN.Report.balance                                         
[amount: "0.92", limits: [rate_limit_remaining: "60", rate_limit: "60"]]
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

## Development

```
git checkout main
git pull
git remote prune origin
git branch -D branch_name
git tag -a v.x.x.x -m "my version x.x.x"
git push origin v.x.x.x
```

## Test

```
mix format
mix credo --strict
mix test
mix coveralls
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exExKeyCDN](https://hexdocs.pm/exExKeyCDN).

