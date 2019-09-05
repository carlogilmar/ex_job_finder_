defmodule RemoteJobsWeb.JobPreviewLive do
  @moduledoc """
    Module for implement live view for show a job
  """
  use Phoenix.LiveView
  alias RemoteJobsWeb.JobPreviewView
  alias RemoteJobs.JobOperator

  def render(assigns) do
    JobPreviewView.render("index.html", assigns)
  end

  def mount(%{path_params: %{"id" => job_id}}, socket) do
    job = JobOperator.find(job_id)
    socket =
      socket
      |> assign(:job, job)
    {:ok, socket}
  end

end
