defmodule RemoteJobs.Job do
  @moduledoc """
    Job model definition
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias RemoteJobs.Track

  @states ["CREATED", "UNAVAILABLE", "AVAILABLE", "EXPIRED"]
  @primary_key {:id, :id, autogenerate: true}
  schema "jobs" do
    field :position, :string
    field :company_name, :string
    field :location_restricted, :string
    field :primary_tag, :string
    field :extra_tags, :string
    field :salary, :string
    field :description, :string
    field :responsabilities, :string
    field :requirements, :string
    field :apply_description, :string
    field :url, :string
    field :email, :string
    field :logo, :string
    field :expire_date, :date
    field :status, :string, default: "CREATED"
    field :visits, :integer
    field :modality, :string
    field :hiring_scheme, :string
    field :contact_info, :string
    field :certified_author, :string
    field :graphic_job, :string
    timestamps()
    has_many :track, Track, on_delete: :delete_all
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:status, :expire_date, :visits, :position, :company_name])
    |> validate_inclusion(:status, @states)
    |> validate_required([])
  end
end
