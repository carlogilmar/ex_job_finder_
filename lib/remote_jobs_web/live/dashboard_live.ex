defmodule RemoteJobsWeb.DashboardLive do

  use Phoenix.LiveView
	alias RemoteJobs.JobManager
  alias RemoteJobsWeb.DashboardView

  def render(assigns) do
    DashboardView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    RemoteJobsWeb.Endpoint.subscribe("dashboard")
		jobs = JobManager.get()
		socket = socket |> assign(:jobs, jobs)
    {:ok, socket}
  end

  def handle_info(%{event: "update_jobs", payload: %{ jobs: jobs}}, socket) do
    {:noreply, assign(socket, :jobs, jobs)}
  end

end
