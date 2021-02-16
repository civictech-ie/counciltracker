# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :counciltracker,
  ecto_repos: [Counciltracker.Repo]

# Configures the endpoint
config :counciltracker, CounciltrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jWqRBXeTcrFvutnzNxGkSgTUlg6+leAxscbONBcZsgn3mUEDK1nxh6PUs92ZwpII",
  render_errors: [view: CounciltrackerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Counciltracker.PubSub,
  live_view: [signing_salt: "xE49Rteu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
