defmodule RemoteJobsWeb.UpdtJobController do
  use RemoteJobsWeb, :controller

  def index(conn, %{"id" => job}) do
    conn |> render("index.html", job: job)
  end
end
