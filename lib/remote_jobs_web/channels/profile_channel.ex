defmodule RemoteJobsWeb.ProfileChannel do
  @moduledoc """
    A module in charge of the profile channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.DateUtil
  alias RemoteJobs.JobManager
  alias RemoteJobs.JobApplicationOperator
  alias RemoteJobs.ProfileOperator

  def join("profile:join", %{"profile" => profile_id}, socket) do
    {profile, skills, tracks} = get_profile(profile_id)
    jobs = JobManager.get() |> jobs_to_view()
    applications =
      profile_id
      |> JobApplicationOperator.get_applications_by_profile()
      |> parse_to_show()

    {:ok, %{profile: profile, skills: skills, tracks: tracks, jobs: jobs, applications: applications}, socket}
  end

  def handle_in("profile:update", %{"attribute" => attribute, "profile" => profile_id, "value" => value}, socket) do
    attrs = Map.new [{String.to_atom(attribute), value}]
    _ = ProfileOperator.update(profile_id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def handle_in("profile:add_skill", %{"skill" => description, "profile" => profile_id}, socket) do
		_ = ProfileOperator.add_skill(profile_id, description)
    {profile, skills, tracks} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills, tracks: tracks}}, socket}
  end

  def handle_in("profile:delete_skill", %{"skill" => skill_id, "profile" => profile_id}, socket) do
		_ = ProfileOperator.delete_skill(skill_id)
    {profile, skills, tracks} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills, tracks: tracks}}, socket}
  end

  def handle_in("profile:add_track", %{"track" => track, "profile" => profile_id}, socket) do
		_ = ProfileOperator.add_tracking(profile_id, track)
    {profile, skills, tracks} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills, tracks: tracks}}, socket}
  end

  def handle_in("profile:delete_track", %{"track" => track_id, "profile" => profile_id}, socket) do
		_ = ProfileOperator.delete_tracking(track_id)
    {profile, skills, tracks} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills, tracks: tracks}}, socket}
  end

	def get_profile(profile_id) do
		profile_id
		|> ProfileOperator.get_by_id()
		|> normalize_for_show_in_view()
	end

  def normalize_for_show_in_view(profile) do
    date_parsed = NaiveDateTime.to_string(profile.inserted_at)
    inserted_at = DateUtil.convert_to_spanish_date_and_hour(date_parsed)
		skills = normalize_skills_and_tracks(profile.skill)
		tracks = normalize_skills_and_tracks(profile.candidate_track)
		profile =
    %{
      description: profile.description,
      email: profile.email,
      experience: profile.experience,
      id: profile.id,
      inserted_at: inserted_at,
      name: profile.name,
      phone: profile.phone,
    }
   {profile, skills, tracks}
  end

	def normalize_skills_and_tracks([]), do: []
  def normalize_skills_and_tracks(skills) do
		normalized_skills =
		  for skill <- skills do
		  	date_parsed = NaiveDateTime.to_string(skill.inserted_at)
		  	inserted_at = DateUtil.convert_to_spanish_date_and_hour(date_parsed)
		  	%{
		  		id: skill.id,
		  		description: skill.description,
		  		inserted_at: inserted_at
		  		}
		  end
		Enum.reverse(normalized_skills)
	end

  defp jobs_to_view(jobs) do
    for job <- jobs do
      %{
        position: job.position,
        id: job.id,
        company_name: job.company_name
      }
    end
  end

  def parse_to_show(applications) do
    for application <- applications do
      %{
        id: application.id,
        job: application.job.position,
        company: application.job.company_name,
      }
    end
  end
end
