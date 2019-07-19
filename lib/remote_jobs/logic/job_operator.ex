defmodule RemoteJobs.JobOperator do
  @moduledoc """
    A module in charge of job managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.Repo
  alias RemoteJobs.JobUtil
  alias RemoteJobs.Job
  @status "CREATED"

  def create(job) do
    %Job{
      position: job["position"],
      company_name: job["company_name"],
      location_restricted: job["location_restricted"],
      primary_tag: job["primary_tag"],
      extra_tags: job["extra_tags"],
      salary: job["salary"],
      description: job["description"],
      responsabilities: job["responsabilities"],
      requirements: job["requirements"],
      apply_description: job["apply_description"],
      url: job["url"],
      email: job["email"],
      logo: "http://carlogilmar.xyz/index_files/carlogilmar.png",
      expire_date: JobUtil.get_expired_date()
    }
    |> Repo.insert()
  end

  def find_all() do
    query = from(j in Job, where: j.status == @status)
    Repo.all(query)
  end
end
