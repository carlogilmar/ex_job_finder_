defmodule RemoteJobsWeb.DashboardLive do
  @moduledoc """
    A module in charge of the interactions on the dashboard view.
  """
  use Phoenix.LiveView
  alias RemoteJobs.JobManager
  alias RemoteJobsWeb.DashboardView
  alias RemoteJobsWeb.Endpoint

  def render(assigns) do
    DashboardView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    Endpoint.subscribe("dashboard")
    jobs = JobManager.get()
    quantity = length(jobs)

    socket =
      socket
      |> assign(:jobs, jobs)
      |> assign(:quantity, quantity)

    {:ok, socket}
  end

  def handle_info(%{event: "update_jobs", payload: %{jobs: jobs}}, socket) do
    quantity = length(jobs)

    socket =
      socket
      |> assign(:jobs, jobs)
      |> assign(:quantity, quantity)

    {:noreply, socket}
  end
end
