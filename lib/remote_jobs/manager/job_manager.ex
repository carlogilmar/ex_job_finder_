defmodule RemoteJobs.JobManager do
  @moduledoc """
    A module in charge of all the tasks related to the jobs.
  """
  alias RemoteJobs.EmailManager
  alias RemoteJobs.JobOperator
  alias RemoteJobsWeb.Endpoint
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def create(job) do
    GenServer.cast(__MODULE__, {:create, job})
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
    job_status = JobOperator.create(job)
    notify_and_update.(job_status)
    {:noreply, state}
  end

  def handle_cast({:update_live_dashboard}, state) do
    _ = send(self(), :update_dashboard)
    {:noreply, state}
  end

  defp notify_and_update() do
    fn
      {:ok, job} ->
        _ = EmailManager.send_confirmation(job.email)
        _ = send(self(), :update_dashboard)

      {:error_in_payment, _job} ->
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
