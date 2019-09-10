defmodule RemoteJobs.JobOperator do
  @moduledoc """
  A module in charge of job managment.
  This module is using Railway through ROP macro

  Review https://hexdocs.pm/rop/readme.html for more details

  Rop pipe: >>>
  Rop tee: tee(fun)
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
      graphic_job: job["job_url"],
      email: job["email"],
      logo: img_url,
      expire_date: DateUtil.get_expired_date(),
      modality: job["modality"],
      hiring_scheme: job["hiring_scheme"],
      contact_info: job["contact_info"],
      certified_author: job["certified_author"]
    }
    |> Repo.insert()
    >>> tee(track())
  end

  # Get
  def find_all() do
    query =
      from(j in Job,
        order_by: [desc: j.inserted_at]
      )

    query
    |> Repo.all()
  end

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

  def find(job_id) do
    job = Repo.get(Job, job_id)
    [job] = get_extra_tags.([job])
    job
  end

  def find_all_paid_jobs, do: find_all("AVAILABLE")


  # Update
  def update(job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  def update_paid_job(%{:job => job}) do
    job
    |> update(%{status: "CREATED"})
    >>> tee(track())
  end

  def update_expired_job(job) do
    job
    |> update(%{status: "EXPIRED"})
    >>> tee(track())
  end

  def update_status(job_id, status) do
    job = Repo.get(Job, job_id)

    job
    |> update(%{status: status})
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
