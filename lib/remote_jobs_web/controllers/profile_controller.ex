defmodule RemoteJobsWeb.ProfileController do
  use RemoteJobsWeb, :controller
  alias RemoteJobs.ProfileOperator

  def index(conn, %{"id" => profile}) do
    render(conn, "index.html", profile: profile)
  end

  def delete(conn, %{"id" => profile}) do
    _ = ProfileOperator.delete_profile(profile)
    redirect(conn, to: "/management")
  end
end
