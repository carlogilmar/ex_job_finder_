defmodule RemoteJobs.Session do
	alias RemoteJobs.UserOperator
	@user_not_found "Usuario no encontrado"
  @wrong_password "Password inválida"

	def auth_user(user, password) do
		user
		|> UserOperator.get_by_username()
		|> ensure_password(password)
	end

	def ensure_password(nil, _password), do: {:error, @user_not_found}
	def ensure_password(user, password) do
		password
		|> Argon2.verify_pass(user.password)
    |> auth_password_hash(user)
	end

	def auth_password_hash(true, user), do: {:ok, user}
	def auth_password_hash(false, _user), do: {:error, @wrong_password}

end
