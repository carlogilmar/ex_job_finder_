defmodule RemoteJobsWeb.ApplicationChannel do
  @moduledoc """
    A module in charge of the application channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.JobApplicationOperator

  def join("application:join", %{"application" => application_id}, socket) do
    application = application_id |> JobApplicationOperator.get()
    application_to_show = application |> parse_to_show()
    tracks = application_id |> JobApplicationOperator.get_tracking() |> parse_tracking()
    {:ok, %{application: application_to_show, tracks: tracks}, socket}
  end

  def handle_in("application:add_track", %{"track" => track, "application" => application_id}, socket) do
    _ = JobApplicationOperator.add_tracking(application_id, track)
    tracks = application_id |> JobApplicationOperator.get_tracking() |> parse_tracking()
    {:reply, {:ok, %{status: "200", tracks: tracks}}, socket}
  end

  def parse_tracking(tracks) do
		for track <- tracks do
			%{
				description: track.description,
				id: track.id
			}
		end
  end

  def parse_to_show(application) do
    %{
      id: application.id,
      position: application.job.position,
      company_name: application.job.company_name,
      profile_name: application.profile.name
    }
  end

end
