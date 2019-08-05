defmodule RemoteJobs.Track do
  @moduledoc """
    Job model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.Job

  @primary_key {:id, :id, autogenerate: true}
  schema "tracks" do
    field :description, :string
    timestamps()
    belongs_to :job, Job
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
