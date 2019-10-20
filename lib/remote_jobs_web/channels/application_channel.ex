defmodule RemoteJobsWeb.ApplicationChannel do
  @moduledoc """
    A module in charge of the application channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.JobApplicationOperator

  def join("application:join", %{"application" => application_id}, socket) do
    application =
      application_id
      |> JobApplicationOperator.get()
      |> parse_to_show()

    {:ok, %{application: application}, socket}
  end

  def parse_to_show(application) do
    %{
      id: application.id,
      position: application.job.position,
      company_name: application.job.company_name,
    }
  end


end
