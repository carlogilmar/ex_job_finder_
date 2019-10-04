defmodule RemoteJobsWeb.LoginController do
  use RemoteJobsWeb, :controller
	alias RemoteJobs.Session

  def index(conn, params) do
		form_params = Map.has_key?(params, "_csrf_token")
		validate_params.({form_params, conn, params})
	end

  defp validate_params do
		fn
			{false, conn, _params} ->
				render(conn, "index.html", error: "")
			{true, conn, params} ->
				session = Session.auth_user(params["username"], params["password"])
				login_reply(session, conn)
		end
	end

	defp login_reply({:error, error}, conn) do
		conn |> render("index.html", error: error)
	end

  defp login_reply({:ok, user}, conn) do
    session = RemoteJobs.Guardian.encode_and_sign(user)
    RemoteJobs.Guardian.Plug.sign_in(conn, session) |> redirect(to: "/auth")
  end

  def home(conn, params) do
		render(conn, "home.html")
	end

end
