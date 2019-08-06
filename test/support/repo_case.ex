defmodule RemoteJobs.RepoCase do
	use ExUnit.CaseTemplate

	using do
		quote do
			alias RemoteJobs.Repo

			import Ecto
			import Ecto.Query
			import RemoteJobs.Repo

			# and any other stuff
		end
	end

	setup tags do
		:ok = Ecto.Adapters.SQL.Sandbox.checkout(RemoteJobs.Repo)

		unless tags[:async] do
			Ecto.Adapters.SQL.Sandbox.mode(RemoteJobs.Repo, {:shared, self()})
		end

		:ok
	end
end
