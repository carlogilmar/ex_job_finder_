defmodule RemoteJobs.ProfileOperator do
  @moduledoc """
  A module in charge of profile managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.Profile
  alias RemoteJobs.Repo

  def create_profile(name) do
    %Profile{}
    |> Profile.changeset(%{name: name})
    |> Repo.insert()
  end

  def get_by_id(profile_id) do
    Repo.get(Profile, profile_id) |> Repo.preload([:skill])
  end

  def update(profile_id, attrs) do
    profile_id
    |> get_by_id()
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

end
