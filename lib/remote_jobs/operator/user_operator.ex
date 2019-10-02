defmodule RemoteJobs.UserOperator do
  @moduledoc """
    User operator definition
  """
  alias RemoteJobs.Repo
  alias RemoteJobs.User

  def create_user(username, role, password) do
    hash = hash_password(password)
    %User{}
    |> User.changeset(%{username: username, password: hash, role: role})
    |> Repo.insert()
  end

  defp hash_password(password), do: Argon2.hash_pwd_salt(password)

end
