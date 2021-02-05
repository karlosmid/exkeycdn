ExUnit.start()

Mox.defmock(ExKeyCDN.MockZone, for: ExKeyCDN.ZoneBehaviour)
Application.put_env(:exkeycdn, :zone, ExKeyCDN.MockZone)
Mox.defmock(ExKeyCDN.MockZoneAlias, for: ExKeyCDN.ZoneAliasBehaviour)
Application.put_env(:exkeycdn, :zone_alias, ExKeyCDN.MockZoneAlias)
Mox.defmock(ExKeyCDN.MockHTTP, for: ExKeyCDN.HTTPBehaviour)
Application.put_env(:exkeycdn, :http, ExKeyCDN.MockHTTP)
