# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :ethic_share,
  ecto_repos: [EthicShare.Repo]

config :ethic_share_web,
  ecto_repos: [EthicShare.Repo],
  generators: [context_app: :ethic_share]

# Configures the endpoint
config :ethic_share_web, EthicShareWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cZW1XYHTTwnO5Ha/XSFBV02g6+brItyE236pcIPBN/3HpnAwIVrJxR7kK4neEEz1",
  render_errors: [view: EthicShareWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EthicShareWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "Ckmkw8UT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
