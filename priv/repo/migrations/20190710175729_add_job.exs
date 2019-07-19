defmodule RemoteJobs.Repo.Migrations.AddJob do
  use Ecto.Migration

  def change do
    create table(:jobs, primary_key: false) do
      add :id, :serial, primary_key: true
      add :position, :string
      add :company_name, :string
      add :location_restricted, :string
      add :primary_tag, :string
      add :extra_tags, :string
      add :salary, :string
      add :description, :string
      add :responsabilities, :string
      add :requirements, :string
      add :apply_description, :string
      add :url, :string
      add :email, :string
      add :logo, :string
      add :expire_date, :date
      add :status, :string
      timestamps()
    end
  end
end
