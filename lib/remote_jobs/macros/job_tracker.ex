defmodule JobTracker do
  @moduledoc """
  This macro is for create the track logger
  for every job created
  This will display the log and create a track
  iex> track(job)
  """
  alias RemoteJobs.TrackerManager

  require Logger
  defmacro __using__([]) do
    quote do
      def track(job) do
        msg = "Vacante ID #{job.id}, Status: #{job.status}"
        _ = TrackerManager.create(job, msg)
        Logger.info("\n Job Tracker :: #{msg} ::")
      end
    end
  end
end
