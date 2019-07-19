defmodule RemoteJobsWeb.Router do
  use RemoteJobsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
    plug :put_layout, {RemoteJobsWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RemoteJobsWeb do
    pipe_through :browser

    # get "/", PageController, :index
    live "/", DashboardLive
    get "/job", JobController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RemoteJobsWeb do
  #   pipe_through :api
  # end
end
