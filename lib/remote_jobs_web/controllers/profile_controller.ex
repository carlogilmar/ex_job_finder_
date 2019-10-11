defmodule RemoteJobsWeb.ProfileController do
  use RemoteJobsWeb, :controller

  def index(conn, %{"id" => profile}) do
    render(conn, "index.html", profile: profile)
  end
end
