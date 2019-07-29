defmodule RemoteJobs.JobOperator do
  @moduledoc """
    A module in charge of job managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.DateUtil
  alias RemoteJobs.Job
  alias RemoteJobs.ParserUtil
  alias RemoteJobs.Repo
  alias RemoteJobs.UploadOperator
  @status "CREATED"

  def create(job) do
    job["logo"]
    |> UploadOperator.up_img_to_cloudinary()
    |> store_job(job)
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
    |> Repo.insert()
  end

  def find_all do
    query = from(j in Job, where: j.status == @status)
    jobs = Repo.all(query)
    get_extra_tags.(jobs)
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
