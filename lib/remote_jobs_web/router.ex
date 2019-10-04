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

	pipeline :browser_pipeline do
		plug RemoteJobs.Guardian.BrowserPipeline
	end

	pipeline :ensure_auth do
		plug Guardian.Plug.EnsureAuthenticated
	end

  scope "/", RemoteJobsWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/tracking/:id", TrackingLive
    get "/post", JobController, :index
    get "/update/:id", UpdtJobController, :index
    live "/preview/:id", JobPreviewLive
    live "/to_approve/:id", ApprovePreviewLive
		live "/suscriptors", SuscriptorsLive

    get "/login", LoginController, :index
    get "/logout", LoginController, :logout
    post "/login", LoginController, :login

    # Simple Post Job
    get "/postajob", MinimalJobController, :index

  end

	scope "/management", RemoteJobsWeb do
		pipe_through [:browser, :browser_pipeline, :ensure_auth]
    live "/", ManagementLive
	end

end
