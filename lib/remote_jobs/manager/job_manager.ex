defmodule RemoteJobs.JobManager do
  alias RemoteJobs.JobOperator
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def create(job) do
    GenServer.cast(__MODULE__, {:create, job})
  end

	def get() do
		GenServer.call(__MODULE__, :get)
	end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:create, job}, state) do
    _ = JobOperator.create(job)
		send self(), :update_dashboard
		{:noreply, state}
	end

	def handle_info(:update_dashboard, state) do
    jobs = JobOperator.find_all()
    RemoteJobsWeb.Endpoint.broadcast("dashboard", "update_jobs", %{jobs: jobs})
		{:noreply, state}
	end

  def handle_call(:get, _from, state) do
    jobs = JobOperator.find_all()
    {:reply, jobs, state}
  end

end
