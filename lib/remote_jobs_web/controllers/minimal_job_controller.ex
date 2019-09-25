defmodule RemoteJobsWeb.MinimalJobController do
  use RemoteJobsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
