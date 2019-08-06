defmodule RemoteJobs.TrackerOperator do
  @moduledoc """
  This contains the functions for
  track important changes in this app
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.Repo
  alias RemoteJobs.Track

  def create(job, description) do
    track = %Track{job: job, description: description}
    track |> Repo.insert!()
  end

  def get_tracking do
    query = from(
      track in Track,
      order_by: [desc: track.inserted_at],
      limit: 20,
      preload: [:job])
    Repo.all(query)
  end
end
