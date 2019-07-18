defmodule RemoteJobsWeb.JobsChannel do
	use Phoenix.Channel
	alias RemoteJobs.JobManager

	def join("remote:job", _msg, socket) do
		{:ok, [], socket}
	end

	def handle_in("remote:create", %{"data" => job}, socket) do
		_ = JobManager.create(job)
		{:noreply, socket}
	end

end
