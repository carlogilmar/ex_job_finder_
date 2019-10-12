defmodule RemoteJobsWeb.ProfileChannel do
  @moduledoc """
    A module in charge of the profile channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.DateUtil
  alias RemoteJobs.ProfileOperator

  def join("profile:join", %{"profile" => profile_id}, socket) do
    {profile, skills} = get_profile(profile_id)
    {:ok, %{profile: profile, skills: skills}, socket}
  end

  def handle_in("profile:update", %{"attribute" => attribute, "profile" => profile_id, "value" => value}, socket) do
    attrs = Map.new [{String.to_atom(attribute), value}]
    _ = ProfileOperator.update(profile_id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def handle_in("profile:add_skill", %{"skill" => description, "profile" => profile_id}, socket) do
		_ = ProfileOperator.add_skill(profile_id, description)
    {profile, skills} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills}}, socket}
  end

  def handle_in("profile:delete_skill", %{"skill" => skill_id, "profile" => profile_id}, socket) do
		_ = ProfileOperator.delete_skill(skill_id)
    {profile, skills} = get_profile(profile_id)
    {:reply, {:ok, %{status: "200", profile: profile, skills: skills}}, socket}
  end

	def get_profile(profile_id) do
		profile_id
		|> ProfileOperator.get_by_id()
		|> normalize_for_show_in_view()
	end

  def normalize_for_show_in_view(profile) do
    date_parsed = NaiveDateTime.to_string(profile.inserted_at)
    inserted_at = DateUtil.convert_to_spanish_date_and_hour(date_parsed)
		skills = normalize_skills(profile.skill)
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
   {profile, skills}
  end

	def normalize_skills([]), do: []
  def normalize_skills(skills) do
		for skill <- skills do
			%{
				id: skill.id,
				description: skill.description
				}
		end
	end

end
