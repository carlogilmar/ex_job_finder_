defmodule RemoteJobs.Repo.Migrations.AddApplication do
  use Ecto.Migration

  def change do
    create table(:job_applications, primary_key: false) do
      add :id, :serial, primary_key: true
      timestamps()
      add :job_id, references(:jobs)
      add :profile_id, references(:profiles)
    end

    create table(:application_tracks, primary_key: false) do
      add :id, :serial, primary_key: true
      add :description, :text
      timestamps()
      add :job_application_id, references(:job_applications)
    end
  end
end
