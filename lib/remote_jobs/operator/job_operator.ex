defmodule RemoteJobs.JobOperator do
  @moduledoc """
    A module in charge of job managment.
  """
  require Logger
  use Rop
  use JobTracker
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.DateUtil
  alias RemoteJobs.Job
  alias RemoteJobs.ParserUtil
  alias RemoteJobs.Repo

  # Create
  def create_job(img_url, job) do
    %Job{
      position: job["position"],
      company_name: job["company_name"],
      location_restricted: job["location_restricted"],
      primary_tag: ParserUtil.resume_tags().(job["primary_tag"]),
      extra_tags: ParserUtil.resume_tags().(job["extra_tags"]),
      salary: job["salary"],
      description: job["description"],
      responsabilities: job["responsabilities"],
      requirements: job["requirements"],
      apply_description: job["apply_description"],
      url: job["url"],
      email: job["email"],
      logo: img_url,
      expire_date: DateUtil.get_expired_date()
    }
    |> Repo.insert()
    >>> tee(track())
  end

  # Get
  def find_all(status) do
    query =
      from(j in Job,
        where: j.status == ^status,
        order_by: [desc: j.inserted_at]
      )

    query
    |> Repo.all()
    |> get_extra_tags.()
  end

  def find(job_id), do: Repo.get(Job, job_id)
  def find_all_paid_jobs, do: find_all("PAID")

  # Update
  def update(job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  def update_paid_job(job) do
    job
      |> update(%{status: "PAID"})
      >>> tee(track())
  end

  def update_expired_job(job) do
    job
      |> update(%{status: "EXPIRED"})
      >>> tee(track())
  end

  #delete
  def delete(job) do
    job
    |> Repo.delete!()
    Logger.info("\n ::Job Tracker:: Job ID #{job.id} -> DELETED IN DB, PAYMENT FAIL! \n")
  end

  defp get_extra_tags do
    fn
      [] ->
        []

      jobs ->
        for job <- jobs do
          extra_tags = ParserUtil.get_tags().(job.extra_tags)
          %{job | extra_tags: extra_tags}
        end
    end
  end
end
