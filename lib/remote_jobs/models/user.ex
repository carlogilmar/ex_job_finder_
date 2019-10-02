defmodule RemoteJobs.User do
  @moduledoc """
    User model definition
  """
  use Ecto.Schema
  import Ecto.Changeset

  @roles ["ADMIN"]
  @primary_key {:id, :id, autogenerate: true}
  schema "users" do
    field :username, :string
    field :role, :string
    field :password, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :role, :password])
    |> validate_inclusion(:role, @roles)
    |> validate_required([])
  end
end
