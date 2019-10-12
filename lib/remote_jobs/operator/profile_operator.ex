defmodule RemoteJobs.ProfileOperator do
  @moduledoc """
  A module in charge of profile managment.
  """
  alias RemoteJobs.Skill
  alias RemoteJobs.Profile
  alias RemoteJobs.Repo

  def create_profile(name) do
    %Profile{}
    |> Profile.changeset(%{name: name})
    |> Repo.insert()
  end

  def get_all() do
    Repo.all(Profile) |> Repo.preload([:skill])
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

	def add_skill(profile_id, skill) do
		profile = profile_id |> get_by_id()
		%Skill{description: skill, profile: profile} |> Repo.insert()
	end

  def delete_skill(skill_id) do
		skill = Repo.get(Skill, skill_id)
    skill |> Repo.delete!()
  end

  def delete_profile(profile_id) do
		profile = Repo.get(Profile, profile_id)
    profile |> Repo.delete!()
  end
end
