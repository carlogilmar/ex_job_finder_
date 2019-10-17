defmodule RemoteJobs.ApplicationTrack do
  @moduledoc """
    Candidate track model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.JobApplication

  @primary_key {:id, :id, autogenerate: true}
  schema "application_tracks" do
    field :description, :string
    timestamps()
    belongs_to :job_application, JobApplication
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:description])
    |> validate_required([])
  end
end
