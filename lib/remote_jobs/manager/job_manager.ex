defmodule RemoteJobs.JobManager do
  @moduledoc """
    A module in charge of all the tasks related to the jobs.
  """
  alias RemoteJobs.EmailManager
  alias RemoteJobs.JobOperator
  alias RemoteJobs.Tracker
  alias RemoteJobsWeb.Endpoint
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def create(job) do
    GenServer.cast(__MODULE__, {:create, job})
  end

  def update_visit_counter(job_id) do
    GenServer.cast(__MODULE__, {:update_visit_counter, job_id})
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def update_live_dashboard do
    GenServer.cast(__MODULE__, {:update_live_dashboard})
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:create, job}, state) do
    Tracker.track_operation({:try_create_job, job["email"]})
    job_status = JobOperator.create(job)
    notify_and_update.(job_status)
    {:noreply, state}
  end

  def handle_cast({:update_visit_counter, job_id}, state) do
    job = JobOperator.find(job_id)
    Tracker.track_operation("RemoteJobs", "Alguien visitó la vacante #{job.position}")
    _ = JobOperator.update(job, %{visits: job.visits + 1})
    _ = send(self(), :update_dashboard)
    {:noreply, state}
  end

  def handle_cast({:update_live_dashboard}, state) do
    _ = send(self(), :update_dashboard)
    {:noreply, state}
  end

  defp notify_and_update() do
    fn
      {:ok, job} ->
        Tracker.track_operation({:job_published, job.email})
        _ = EmailManager.send_confirmation(job.email)
        _ = send(self(), :update_dashboard)

      {:error_in_payment, job} ->
        Tracker.track_operation({:payment_rejected, job.email})
        :send_email_with_errors

      _ ->
        raise "Job Manager: Error al crear job"
    end
  end

  def handle_info(:update_dashboard, state) do
    jobs = JobOperator.find_all_paid_jobs()
    _broadcast = Endpoint.broadcast("dashboard", "update_jobs", %{jobs: jobs})
    {:noreply, state}
  end

  def handle_call(:get, _from, state) do
    jobs = JobOperator.find_all_paid_jobs()
    {:reply, jobs, state}
  end
end
