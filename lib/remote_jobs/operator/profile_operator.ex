defmodule RemoteJobs.ProfileOperator do
  @moduledoc """
  A module in charge of profile managment.
  """
  import Ecto.Query, only: [from: 2]
  alias RemoteJobs.CandidateTrack
  alias RemoteJobs.Skill
  alias RemoteJobs.Profile
  alias RemoteJobs.Repo

  def create_profile(name) do
    %Profile{}
    |> Profile.changeset(%{name: name})
    |> Repo.insert()
  end

  def get_all() do
    query =
      from(j in Profile,
        order_by: [desc: j.inserted_at]
      )

    query |> Repo.all() |> Repo.preload([:skill, :candidate_track])
  end

  def get_by_id(profile_id) do
    Repo.get(Profile, profile_id) |> Repo.preload([:skill, :candidate_track])
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

	def add_tracking(profile_id, tracking) do
		profile = profile_id |> get_by_id()
		%CandidateTrack{description: tracking, profile: profile} |> Repo.insert()
	end

  def delete_tracking(track_id) do
		track = Repo.get(CandidateTrack, track_id)
    track |> Repo.delete!()
  end
end
