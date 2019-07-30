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
      add :description, :text
      add :responsabilities, :text
      add :requirements, :text
      add :apply_description, :text
      add :url, :string
      add :email, :string
      add :logo, :string
      add :expire_date, :date
      add :status, :string
      add :visits, :integer, default: 0
      timestamps()
    end
  end
end
