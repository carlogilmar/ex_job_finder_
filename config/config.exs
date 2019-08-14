use Mix.Config

config :remote_jobs,
  ecto_repos: [RemoteJobs.Repo]

# Configures the endpoint
config :remote_jobs, RemoteJobsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "B0k3rREDoyeOy/aeJdEHF9hmEUmhvS+DubNAbHAvsl9ou3MoTCPC8sXTuxIwrD5b",
  render_errors: [view: RemoteJobsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RemoteJobs.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "v9A3XbdFJ7DGyUpax3MGjEveJAPmVFe1"],
  cloudinary_url: System.get_env("CLOUDINARY_CLOUD"),
  cloudinary_preset: System.get_env("CLOUDINARY_PRESET")

# Configures Elixir's Logger
config :logger,
  format: "$time $metadata[$level] $message\n",
  backends: [
    {LoggerFileBackend, :remote_jobs},
    :console
  ]

config :logger, :remote_jobs,
  path: "remote_jobs.log",
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Bamboo
config :remote_jobs, RemoteJobs.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

# Conekta
config :conekta,
  publickey: "key_Fq9rBzrPqu7QkwCqmykXquQ",
  privatekey: "key_zktvjcBzBSx4cqYHk2wuWQ"

# Scheduler
config :remote_jobs, RemoteJobs.Scheduler,
  jobs: [
    {"@daily", {RemoteJobs.ExpireOperator, :check_paid_jobs_expiration, []}}
  ]

# Configures the price charged when publishing a job
config :remote_jobs, job_price: 5_000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
