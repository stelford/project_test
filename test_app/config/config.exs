# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :test_app,
  ecto_repos: [TestApp.Repo]

# Configures the endpoint
config :test_app, TestAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TgEdyvNHRymKFYnom/cpTDaXBbFwnmJgb/8qDKIA9TZBOYvj4srNRC6m2cMpbUMV",
  render_errors: [view: TestAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TestApp.PubSub,
  live_view: [signing_salt: "lzUs4dmP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
