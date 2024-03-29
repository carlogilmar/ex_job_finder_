defmodule RemoteJobs.Profile do
  @moduledoc """
    Profile model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.Skill
  alias RemoteJobs.CandidateTrack

  @primary_key {:id, :id, autogenerate: true}
  schema "profiles" do
    field :name, :string
    field :description, :string, default: "Sin descripción"
    field :experience, :string, default: "Sin experiencia"
    field :email, :string, default: "Sin email"
    field :phone, :string, default: "Sin teléfono"
    timestamps()
    has_many :skill, Skill, on_delete: :delete_all
    has_many :candidate_track, CandidateTrack, on_delete: :delete_all
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :description, :experience, :email, :phone])
    |> validate_required([])
  end
end
