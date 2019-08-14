defmodule RemoteJobs.Repo.Migrations.AddOrderIdToJob do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :order_id, :string # Database type
    end
  end
end
