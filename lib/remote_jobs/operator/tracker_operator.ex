defmodule RemoteJobs.TrackerOperator do
  @moduledoc """
  This contains the functions for
  track important changes in this app
  """
  alias RemoteJobs.Job
  alias RemoteJobs.Repo
  alias RemoteJobs.Track

  def create(job, description) do
    track = %Track{job: job, description: description}
    track |> Repo.insert!()
  end

  def get_tracking(job_id) do
    job =
      Repo.get(Job, job_id)
      |> Repo.preload([:track])
    Enum.reverse(job.track)
  end
end
