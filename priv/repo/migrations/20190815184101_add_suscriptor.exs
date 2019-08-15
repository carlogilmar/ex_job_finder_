defmodule RemoteJobs.Repo.Migrations.AddSuscriptor do
  use Ecto.Migration

  def change do
    create table(:suscriptors, primary_key: false) do
      add :id, :serial, primary_key: true
      add :name, :string
      add :email, :string
      timestamps()
    end
    create unique_index(:suscriptors, [:email])
  end
end
