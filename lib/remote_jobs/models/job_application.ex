defmodule RemoteJobs.JobApplication do
  @moduledoc """
    Candidate track model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.ApplicationTrack
  alias RemoteJobs.Job
  alias RemoteJobs.Profile

  @primary_key {:id, :id, autogenerate: true}
  schema "job_applications" do
    timestamps()
    has_many :application_track, ApplicationTrack, on_delete: :delete_all
    belongs_to :job, Job
    belongs_to :profile, Profile
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
