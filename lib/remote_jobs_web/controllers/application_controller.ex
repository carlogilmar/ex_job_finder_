defmodule RemoteJobsWeb.ApplicationController do
  use RemoteJobsWeb, :controller

  def index(conn, %{"id" => application}) do
    render(conn, "index.html", application: application)
  end
end
