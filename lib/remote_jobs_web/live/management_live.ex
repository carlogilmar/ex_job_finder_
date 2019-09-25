defmodule RemoteJobsWeb.ManagementLive do
  @moduledoc """
    Module for implement live view for show the jobs and status
  """
  use Phoenix.LiveView
  alias RemoteJobs.EmailManager
  alias RemoteJobs.JobOperator
  alias RemoteJobsWeb.ApprovePreviewLive
  alias RemoteJobsWeb.ManagementView
  alias RemoteJobsWeb.JobPreviewLive
  alias RemoteJobsWeb.Router.Helpers, as: Routes
  alias RemoteJobsWeb.TrackingLive

  def render(assigns) do
    ManagementView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, set_jobs(socket)}
  end

  def handle_params(params, _url, socket), do: start_process.({params, socket})

  def start_process do
    fn
      {%{"email_to_invite" => email}, socket} ->
        _ = EmailManager.send_invite_email(email)
        {:ok, live_redirect(socket, to: Routes.live_path(socket, RemoteJobsWeb.ManagementLive))}

      {%{}, socket} ->
        {:noreply, socket}
    end
  end

  def handle_event("detail", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, ApprovePreviewLive, job_id))}
  end

  def handle_event("preview_job", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, JobPreviewLive, job_id))}
  end

  def handle_event("tracking", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, TrackingLive, job_id))}
  end

  def handle_event("redirect_url", uri, socket) do
    {:noreply, live_redirect(socket, to: uri)}
  end

  def handle_event("to_unavailable", job_id, socket) do
    job_id = String.to_integer(job_id)
    _ = JobOperator.update_status.({job_id, "UNAVAILABLE"})
    socket = set_jobs(socket)
    {:noreply, socket}
	end

  def handle_event("to_available", job_id, socket) do
    job_id = String.to_integer(job_id)
    _ = JobOperator.update_status.({job_id, "AVAILABLE"})
    socket = set_jobs(socket)
    {:noreply, socket}
	end

  def handle_event("delete", job_id, socket) do
    job_id = String.to_integer(job_id)
    _ = JobOperator.delete_job(job_id)
    socket = set_jobs(socket)
    {:noreply, socket}
	end

	def set_jobs(socket) do
    jobs = JobOperator.find_all()
    socket |> assign(:jobs, jobs)
	end
end
