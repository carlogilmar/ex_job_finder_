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

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:create, job}, state) do
    with {:ok, job_created} <- JobOperator.create(job) do
      _ = EmailManager.send_confirmation(job_created.email)
      _ = send(self(), :update_dashboard)
    else
      _ -> raise "JobManager: Error al intentar crear nuevo job"
    end
    {:noreply, state}
  end

  def handle_info(:update_dashboard, state) do
    jobs = JobOperator.find_all()
    _broadcast = Endpoint.broadcast("dashboard", "update_jobs", %{jobs: jobs})
    {:noreply, state}
  end

  def handle_call(:get, _from, state) do
    jobs = JobOperator.find_all()
    {:reply, jobs, state}
  end
end
