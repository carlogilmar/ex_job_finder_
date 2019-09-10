defmodule RemoteJobsWeb.JobsLive do
  @moduledoc """
    Module for implement live view for show the jobs and status
  """
  use Phoenix.LiveView
  alias RemoteJobs.JobOperator
  alias RemoteJobsWeb.JobsView
  alias RemoteJobsWeb.JobPreviewLive
  alias RemoteJobsWeb.Router.Helpers, as: Routes

  def render(assigns) do
    JobsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = set_jobs(socket)
    {:ok, socket}
  end

  def handle_event("preview_job", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, JobPreviewLive, job_id))}
  end

  def handle_event("redirect_url", uri, socket) do
    {:noreply, live_redirect(socket, to: uri)}
  end

  def handle_event("to_created", job_id, socket) do
    job_id = String.to_integer(job_id)
    _ = JobOperator.update_status(job_id, "CREATED")
    socket = set_jobs(socket)
    {:noreply, socket}
	end

  def handle_event("to_available", job_id, socket) do
    job_id = String.to_integer(job_id)
    _ = JobOperator.update_status(job_id, "AVAILABLE")
    socket = set_jobs(socket)
    {:noreply, socket}
	end

	def set_jobs(socket) do
    jobs = JobOperator.find_all()
    socket |> assign(:jobs, jobs)
	end
end
