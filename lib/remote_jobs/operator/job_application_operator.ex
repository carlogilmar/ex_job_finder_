defmodule RemoteJobs.JobApplicationOperator do
  @moduledoc false
  alias RemoteJobs.JobApplication
  alias RemoteJobs.JobOperator
  alias RemoteJobs.ProfileOperator
  alias RemoteJobs.Repo

  def create_job_application(job_id, profile_id) do
    job = JobOperator.get(job_id)
    profile = ProfileOperator.get_by_id(profile_id)
    %JobApplication{
      job: job,
      profile: profile
    }
    |> Repo.insert()
  end

end
