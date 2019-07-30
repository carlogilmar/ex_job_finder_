defmodule RemoteJobs.JobOperator do
  @moduledoc """
    A module in charge of job managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.DateUtil
  alias RemoteJobs.Job
  alias RemoteJobs.ParserUtil
  alias RemoteJobs.PaymentOperator
  alias RemoteJobs.Repo
  alias RemoteJobs.UploadOperator
  alias RemoteJobs.Tracker

  def create(job) do
    job["logo"]
    |> UploadOperator.up_img_to_cloudinary()
    |> store_job(job)
    |> PaymentOperator.pay_for_publish("card")
    |> publish_job()
  end

  defp publish_job(payment), do: validate_payment.(payment)

  defp validate_payment do
    fn
      {:ok, job} ->
        Tracker.track_operation({:job_created, job.email})
        update(job, %{status: "PAID"})

      {:error_in_payment, job} ->
        {:error_in_payment, job}
    end
  end

  defp store_job(img_url, job) do
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
    |> Repo.insert!()
  end

  def find_all_paid_jobs, do: find_all("PAID")

  def find_all(status) do
    query = from(j in Job, where: j.status == ^status)
    jobs = Repo.all(query)
    get_extra_tags.(jobs)
  end

  def update(job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  def find(job_id), do: Repo.get(Job, job_id)

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
