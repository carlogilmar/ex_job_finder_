defmodule RemoteJobs.ViewerOperator do
  @moduledoc """
    Viewer operator definition
  """
  alias RemoteJobs.Viewer
  alias RemoteJobs.Repo

  def create_viewer(session) do
    %Viewer{
      city: session["city"],
      continent: session["continent_name"],
      country: session["country_name"],
      region: session["region"],
      time_zone: session["time_zone"]["name"],
      latitude: session["latitude"],
      longitude: session["longitude"]
    } |> Repo.insert()
  end

  def get_all do
    Viewer |> Repo.all()
  end

end
