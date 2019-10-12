defmodule RemoteJobs.Repo.Migrations.AddProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :serial, primary_key: true
      add :name, :string
      add :description, :text
      add :experience, :text
      add :email, :string
      add :phone, :text
      timestamps()
    end

    create table(:skills, primary_key: false) do
      add :id, :serial, primary_key: true
      add :description, :text
      timestamps()
      add :profile_id, references(:profiles)
    end

    create table(:candidate_tracks, primary_key: false) do
      add :id, :serial, primary_key: true
      add :description, :text
      timestamps()
      add :profile_id, references(:profiles)
    end
  end
end
