defmodule RemoteJobs.JobApplicationOperator do
  @moduledoc false
  import Ecto.Query, only: [from: 2]
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

  def get(application_id), do: Repo.get(JobApplication, application_id)

  def get_applications_by_profile(profile_id) do
    query = from(j in JobApplication,  where: j.profile_id == ^profile_id)
    Repo.all(query) |> Repo.preload([:application_track])
  end

  def get_applications_by_job(job_id) do
    query = from(j in JobApplication,  where: j.job_id == ^job_id)
    Repo.all(query) |> Repo.preload([:application_track])
  end

end
