defmodule RemoteJobsWeb.AnalyticsController do
  use RemoteJobsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
