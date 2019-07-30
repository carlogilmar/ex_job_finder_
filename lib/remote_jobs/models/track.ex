defmodule RemoteJobs.Track do
  @moduledoc """
    Job model definition
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "tracks" do
    field :author, :string
    field :description, :string
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
