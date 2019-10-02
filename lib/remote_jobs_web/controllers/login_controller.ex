defmodule RemoteJobsWeb.LoginController do
  use RemoteJobsWeb, :controller

  def index(conn, params) do
		form_params = Map.has_key?(params, "_csrf_token")
		v = fn
			false ->
				render(conn, "index.html")
			true ->
        conn |> redirect(to: "/post")
		end
		v.(form_params)
	end

  def home(conn, params) do
		render(conn, "home.html")
	end

end
