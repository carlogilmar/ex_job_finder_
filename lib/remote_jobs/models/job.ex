defmodule RemoteJobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

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
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
