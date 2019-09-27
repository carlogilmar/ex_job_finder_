defmodule RemoteJobsWeb.UpdtJobChannel do
  @moduledoc """
    A module in charge of the job channel.
  """

  use Phoenix.Channel

  def join("updt_job:join", msg, socket) do
    job = %{id: 1, position: "dev", company_name: "md"}
    {:ok, job, socket}
  end

  def handle_in("updt_job:update", %{"attribute" => attribute, "job" => job_id, "value" => value}, socket) do
    IO.puts attribute
    IO.puts job_id
    IO.puts value
    {:reply, {:ok, %{status: "200"}}, socket}
  end

end
