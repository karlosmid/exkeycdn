ExUnit.start()

Mox.defmock(ExKeyCDN.MockZone, for: ExKeyCDN.ZoneBehaviour)
Application.put_env(:ExKeyCDN, :zone, ExKeyCDN.MockZone)
