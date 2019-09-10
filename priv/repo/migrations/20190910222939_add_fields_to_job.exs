defmodule RemoteJobs.Repo.Migrations.AddFieldsToJob do
  use Ecto.Migration

	def change do
		alter table(:jobs) do
      add :modality, :string
      add :hiring_scheme, :string
      add :contact_info, :text
      add :certified_author, :string
      add :graphic_job, :string
			modify :salary, :text
		end
  end
end
