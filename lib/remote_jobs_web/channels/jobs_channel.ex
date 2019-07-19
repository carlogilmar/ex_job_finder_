defmodule RemoteJobsWeb.JobsChannel do
  @moduledoc """
    A module in charge of the job channel.
  """

  use Phoenix.Channel
  alias RemoteJobs.JobManager

  def join("remote:job", _msg, socket) do
    {:ok, [], socket}
  end

	def handle_in("remote:create", %{"data" => job}, socket) do
		res = JobManager.create(job)
    {:reply, {res, %{status: "200"}}, socket}
	end
end
