defmodule RemoteJobsWeb.TrackingLive do
  @moduledoc """
    Module for implement live view for show the tracking
  """
  use Phoenix.LiveView
  alias RemoteJobsWeb.TrackingView
  alias RemoteJobs.TrackerManager
  alias RemoteJobsWeb.Endpoint

  def render(assigns) do
    TrackingView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    Endpoint.subscribe("tracking")
    tracks = TrackerManager.get()

    socket =
      socket
      |> assign(:tracks, tracks)

    {:ok, socket}
  end

  def handle_info(%{event: "update_tracking", payload: %{tracks: tracks}}, socket) do
    socket =
      socket
      |> assign(:tracks, tracks)

    {:noreply, socket}
  end
end
