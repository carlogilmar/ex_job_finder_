defmodule RemoteJobs.Repo do
  use Ecto.Repo,
    otp_app: :remote_jobs,
    adapter: Ecto.Adapters.Postgres
end
