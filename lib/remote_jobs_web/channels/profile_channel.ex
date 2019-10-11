defmodule RemoteJobsWeb.ProfileChannel do
  @moduledoc """
    A module in charge of the profile channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.ParserUtil

  def join("profile:join", %{"profile" => profile}, socket) do
    IO.puts "***************"
    IO.inspect profile
    IO.puts "***************"
    {:ok, %{}, socket}
  end

end
