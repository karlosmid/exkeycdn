# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :exkeycdn,
  api_key: {:system, "api_key"},
  url: "https://api.keycdn.com",
  http_options: [recv_timeout: 60_000],
  http: ExKeyCDN.HTTP
