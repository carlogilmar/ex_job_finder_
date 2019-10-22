defmodule RemoteJobsWeb.ApplicationController do
  use RemoteJobsWeb, :controller
  alias RemoteJobs.JobApplicationOperator

  def index(conn, %{"id" => application}) do
    app = JobApplicationOperator.get(application)
    render(conn, "index.html", application: application, profile: app.profile)
  end

  def delete(conn, %{"id" => application_id}) do
    application = JobApplicationOperator.get(application_id)
    _ = JobApplicationOperator.delete(application_id)
    redirect(conn, to: "/profile/#{application.profile_id}")
  end
end
