defmodule RemoteJobs.TrackerManager do
  @moduledoc """
    Genserver for manage tracker list
  """
  require Logger
  alias RemoteJobs.TrackerOperator
  alias RemoteJobsWeb.Endpoint
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def create(author, description) do
    GenServer.cast(__MODULE__, {:create, author, description})
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def update_live_tracking do
    GenServer.cast(__MODULE__, {:update_live_tracking})
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call(:get, _from, state) do
    tracks = TrackerOperator.get_tracking()
    {:reply, tracks, state}
  end

  def handle_cast({:create, author, description}, state) do
    Logger.info("                      :: Tracker Log ::                    ")
    Logger.info(":: Tracker Log :: AUTHOR: #{author} :: DESC: #{description}")
    _track = TrackerOperator.create(author, description)
    _ = send(self(), :update_tracking)
    {:noreply, state}
  end

  def handle_cast({:update_live_traking}, state) do
    _ = send(self(), :update_tracking)
    {:noreply, state}
  end

  def handle_info(:update_tracking, state) do
    tracks = TrackerOperator.get_tracking()
    _broadcast = Endpoint.broadcast("tracking", "update_tracking", %{tracks: tracks})
    {:noreply, state}
  end
end
