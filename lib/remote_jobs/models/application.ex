defmodule RemoteJobs.Application do
  @moduledoc """
    Candidate track model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.ApplicationTrack
  alias RemoteJobs.Job
  alias RemoteJobs.Profile

  @primary_key {:id, :id, autogenerate: true}
  schema "applications" do
    timestamps()
    has_many :application_track, ApplicationTrack, on_delete: :delete_all
    has_one :job, Job, on_delete: :delete_all
    has_one :profile, Profile, on_delete: :delete_all
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
