defmodule RemoteJobs.JobApplicationOperator do
  @moduledoc false
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.ApplicationTrack
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

  def get(application_id) do
    Repo.get(JobApplication, application_id)
    |> Repo.preload([:job, :application_track, :profile])
  end

  def delete(application_id) do
    Repo.get(JobApplication, application_id)
    |> Repo.preload([:job, :application_track, :profile])
    |> Repo.delete()
  end

  def get_applications_by_profile(profile_id) do
    query = from(j in JobApplication,  where: j.profile_id == ^profile_id, order_by: [desc: j.inserted_at])
    Repo.all(query) |> Repo.preload([:job, :application_track])
  end

  def get_applications_by_job(job_id) do
    query = from(j in JobApplication,  where: j.job_id == ^job_id, order_by: [desc: j.inserted_at])
    Repo.all(query) |> Repo.preload([:job, :application_track])
  end

  def add_tracking(application_id, description) do
    job_application = get(application_id)
    %ApplicationTrack{
      job_application: job_application,
      description: description
    } |> Repo.insert()
  end

  def delete_tracking(track_id) do
    ApplicationTrack |> Repo.get(track_id) |> Repo.delete()
  end

  def get_tracking(application_id) do
    query = from(j in ApplicationTrack,  where: j.job_application_id == ^application_id, order_by: [desc: j.inserted_at])
    Repo.all(query)
  end

end
