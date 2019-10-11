defmodule RemoteJobsWeb.ProfileChannel do
  @moduledoc """
    A module in charge of the profile channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.DateUtil
  alias RemoteJobs.ProfileOperator

  def join("profile:join", %{"profile" => profile_id}, socket) do
    profile =
      profile_id
      |> String.to_integer()
      |> ProfileOperator.get_by_id()
      |> normalize_for_show_in_view()
    {:ok, %{profile: profile}, socket}
  end

  def handle_in("profile:update", %{"attribute" => attribute, "profile" => profile_id, "value" => value}, socket) do
    attrs = Map.new [{String.to_atom(attribute), value}]
    _ = ProfileOperator.update(profile_id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def normalize_for_show_in_view(profile) do
    date_parsed = NaiveDateTime.to_string(profile.inserted_at)
    inserted_at = DateUtil.convert_to_spanish_date_and_hour(date_parsed)
    %{
      description: profile.description,
      email: profile.email,
      experience: profile.experience,
      id: profile.id,
      inserted_at: inserted_at,
      name: profile.name,
      phone: profile.phone,
    }
  end

end
