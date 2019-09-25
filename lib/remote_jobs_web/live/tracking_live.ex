defmodule RemoteJobsWeb.TrackingLive do
  @moduledoc """
    Module for implement live view for show the tracking
  """
  use Phoenix.LiveView
  alias RemoteJobs.JobOperator
  alias RemoteJobs.TrackerOperator
  alias RemoteJobsWeb.Endpoint
  alias RemoteJobsWeb.TrackingView

  def render(assigns) do
    TrackingView.render("index.html", assigns)
  end

  def mount(%{path_params: %{"id" => job_id}}, socket) do
    Endpoint.subscribe("tracking")
    tracks = TrackerOperator.get_tracking(job_id)
    job = JobOperator.find(job_id)

    socket =
      socket
      |> assign(:tracks, tracks)
      |> assign(:job, job)

    {:ok, socket}
  end

end
