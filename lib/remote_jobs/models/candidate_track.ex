defmodule RemoteJobs.CandidateTrack do
  @moduledoc """
    Candidate track model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.Profile

  @primary_key {:id, :id, autogenerate: true}
  schema "candidate_tracks" do
    field :description, :string
    timestamps()
    belongs_to :profile, Profile
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:description, :profile])
    |> validate_required([])
  end
end
