defmodule RemoteJobs.Suscriptor do
  @moduledoc """
    Suscriptor model definition
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "suscriptors" do
    field :name, :string
    field :email, :string
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
