# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_k8s,
  ecto_repos: [PhxK8s.Repo]

# Configures the endpoint
config :phx_k8s, PhxK8sWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rRok2Mcxa09R9tWEZ15RNCLMXmbHnZitzgnmKHQ7w8g/K35MuY5UCPpASlREGb6R",
  render_errors: [view: PhxK8sWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhxK8s.PubSub,
  live_view: [signing_salt: "V87mRVlX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
