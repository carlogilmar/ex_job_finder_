defmodule RemoteJobsWeb.ApprovePreviewLive do
  @moduledoc """
    Module for implement live view for show a job
  """
  use Phoenix.LiveView
  alias RemoteJobsWeb.ApprovePreviewView
  alias RemoteJobs.JobOperator
  alias RemoteJobsWeb.JobPreviewLive
  alias RemoteJobsWeb.TrackingLive
  alias RemoteJobsWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ApprovePreviewView.render("index.html", assigns)
  end

  def mount(%{path_params: %{"id" => job_id}}, socket) do
    job = JobOperator.find(job_id)
    socket =
      socket
      |> assign(:job, job)
    {:ok, socket}
  end

  def handle_event("preview_job", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, JobPreviewLive, job_id))}
  end

  def handle_event("tracking", job_id, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, TrackingLive, job_id))}
  end
end
