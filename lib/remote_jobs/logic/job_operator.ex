defmodule RemoteJobs.JobOperator do
  @moduledoc """
    A module in charge of job managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.Repo
  alias RemoteJobs.JobUtil
  alias RemoteJobs.Job
  @status "CREATED"

  def create(_job) do
    %Job{
      position: "developer",
      company_name: "Codigo Ambar",
      location_restricted: "WorldWide",
      primary_tag: "Development",
      extra_tags: "Software and Open Source",
      salary: "1000",
      description: "Software Engineer que se rife",
      responsabilities: "Programar elixir",
      requirements: "Programar chido",
      apply_description: "Ser blanco",
      url: "https://github.com/carlogilmar/remote-jobs/issues?q=is%3Aopen+is%3Aissue",
      email: "carlogilmar12@gmail.com",
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
