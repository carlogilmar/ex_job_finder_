defmodule RemoteJobs.JobManager do
  @moduledoc """
    A module in charge of all the tasks related to the jobs.
  """
  require Logger
  alias RemoteJobs.Core.JobFlow
  alias RemoteJobs.JobOperator
  alias RemoteJobsWeb.Endpoint
  use GenServer
  @available_status "AVAILABLE"

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def create(job_from_view) do
    GenServer.cast(__MODULE__, {:create, job_from_view})
  end

  def update_visit_counter(job_id) do
    GenServer.cast(__MODULE__, {:update_visit_counter, job_id})
  end

  def update_live_dashboard do
    GenServer.cast(__MODULE__, {:update_live_dashboard})
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call(:get, _from, state) do
    jobs = JobOperator.find_all(@available_status)
    {:reply, jobs, state}
  end

  def handle_cast({:create, job_from_view}, state) do
    job_from_view
    |> JobFlow.publish_job()
    |> update_dashboard.()

    {:noreply, state}
  end

  def handle_cast({:update_visit_counter, job_id}, state) do
    job = JobOperator.find(job_id)
    _ = JobOperator.update(job, %{visits: job.visits + 1})
    _ = send(self(), :update_dashboard)
    {:noreply, state}
  end

  def handle_cast({:update_live_dashboard}, state) do
    _ = send(self(), :update_dashboard)
    {:noreply, state}
  end

  defp update_dashboard do
    fn
      {:ok, _job_created} ->
        Logger.info("\n\n:: Job Manager :: Job Created success! [DONE] \n")
        send(self(), :update_dashboard)

      {:error, reason} ->
        Logger.error("\n\n:: Job Manager :: Error al crear vacante :: <<#{reason.message}>> \n")
    end
  end

  def handle_info(:update_dashboard, state) do
    jobs = JobOperator.find_all(@available_status)
    _broadcast = Endpoint.broadcast("dashboard", "update_jobs", %{jobs: jobs})
    {:noreply, state}
  end
end
