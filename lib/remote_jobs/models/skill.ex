defmodule RemoteJobs.Skill do
  @moduledoc """
    Skill model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.Profile

  @primary_key {:id, :id, autogenerate: true}
  schema "skills" do
    field :description, :string
    timestamps()
    belongs_to :profile, Profile
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:description])
    |> validate_required([])
  end
end
