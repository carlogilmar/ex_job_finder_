defmodule RemoteJobs.JobOperation do
  alias RemoteJobs.Repo

  def create(_job), do: %RemoteJobs.Job{position: "developer"} |> Repo.insert
  def find_all(), do: RemoteJobs.Job |> Repo.all

end
