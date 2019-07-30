defmodule RemoteJobs.Application do
  @moduledoc false

  use Application
  alias RemoteJobsWeb.Endpoint

  def start(_type, _args) do
    children = [
      RemoteJobs.Repo,
      RemoteJobsWeb.Endpoint,
      {RemoteJobs.JobManager, []},
      {RemoteJobs.TrackerManager, []},
      RemoteJobs.Scheduler
    ]

    opts = [strategy: :one_for_one, name: RemoteJobs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
