defmodule RemoteJobsWeb.UpdtJobChannel do
  @moduledoc """
    A module in charge of the job channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.JobOperator

  def join("updt_job:join", %{"job" => job_id}, socket) do
    job =
      job_id
      |> String.to_integer()
      |> JobOperator.find()
      |> UpdtJobUtil.normalize_job()

    {:ok, job, socket}
  end

  def handle_in("updt_job:update", %{"attribute" => attribute, "job" => job_id, "value" => value}, socket) do
    IO.puts attribute
    IO.puts job_id
    IO.puts value
    {:reply, {:ok, %{status: "200"}}, socket}
  end

end

defmodule UpdtJobUtil do

  def normalize_job(job) do
    job
      |> Map.put(:__meta__, "")
      |> Map.put(:expire_date, Date.to_string(job.expire_date))
      |> Map.put(:inserted_at, "")
      |> Map.put(:track, "")
      |> Map.put(:updated_at, "")
      |> Map.from_struct()
  end

end
