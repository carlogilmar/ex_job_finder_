defmodule RemoteJobsWeb.JobsChannel do
	use Phoenix.Channel
	alias RemoteJobs.JobOperation

	def join("remote:job", _msg, socket) do
		{:ok, [], socket}
	end

	def handle_in("remote:create", %{"data" => job}, socket) do
		_ = JobOperation.create(job)
		{:noreply, socket}
	end

end
