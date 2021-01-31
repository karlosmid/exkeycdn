ExUnit.start()

Mox.defmock(KeyCDN.MockZone, for: KeyCDN.ZoneBehaviour)
Application.put_env(:keycdn, :zone, KeyCDN.MockZone)
