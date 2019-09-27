defmodule RemoteJobsWeb.UpdtJobChannel do
  @moduledoc """
    A module in charge of the job channel.
  """

  use Phoenix.Channel
  alias RemoteJobs.JobManager

  def join("updt_job:join", msg, socket) do
    {:ok, [], socket}
  end

end
