defmodule RemoteJobsWeb.LoginController do
  use RemoteJobsWeb, :controller

  def index(conn, params) do
		form_params = Map.has_key?(params, "_csrf_token")
		v = fn
			false ->
				render(conn, "index.html", error: "")
			true ->
				user = %{id: 1, username: "carlogilmar", password: "1234567890"}
				login_reply({:ok, user}, conn)
		end
		v.(form_params)
	end

	defp error_in_login(conn) do
		conn |> render("index.html", error: "Error al iniciar sesión")
	end

  defp login_reply({:ok, user}, conn) do
    user = RemoteJobs.Guardian.encode_and_sign(user)
    RemoteJobs.Guardian.Plug.sign_in(conn, user) |> redirect(to: "/auth")
  end

  def home(conn, params) do
		render(conn, "home.html")
	end

end
