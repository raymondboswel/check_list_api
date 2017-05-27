# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :check_list_api,
  ecto_repos: [CheckListApi.Repo]

# Configures the endpoint
config :check_list_api, CheckListApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xv7z04GeNtAsRF4JDajWI9ZjqDm2axTVmfsZF65uofOfD6S5uNxFAoWDalCbSPC1",
  render_errors: [view: CheckListApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CheckListApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "CheckListApi",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "d3tz6o3UkRYED94cNMXGBS3wmP07ajRzv+4SaXRY5RFsHwmph5J9UjPmTVOp0SUc",
  serializer: MyApp.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
