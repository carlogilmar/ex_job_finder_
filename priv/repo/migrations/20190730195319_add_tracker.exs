defmodule RemoteJobs.Repo.Migrations.AddTracker do
  use Ecto.Migration

  def change do
    create table(:tracks, primary_key: false) do
      add :id, :serial, primary_key: true
      add :author, :string
      add :description, :string
      timestamps()
      add :job_id, references(:jobs)
    end
  end
end
