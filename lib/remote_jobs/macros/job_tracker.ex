defmodule JobTracker do
  @moduledoc """
  This macro is for create the track logger
  for every job created
  This will display the log and create a track
  iex> track(job)
  """

  require Logger
  defmacro __using__([]) do
    quote do
      def track(job) do
        msg = "\n ::Job Tracker:: Job ID #{job.id} -> #{job.status} \n"
        Logger.info(msg)
      end
    end
  end
end
