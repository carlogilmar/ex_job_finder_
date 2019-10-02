defmodule RemoteJobs.Guardian.BrowserPipeline do

	use Guardian.Plug.Pipeline,
		otp_app: :remote_jobs,
		module: RemoteJobs.Guardian,
		error_handler: RemoteJobs.Guardian.ErrorHandler

	plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
	plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
	plug Guardian.Plug.LoadResource, allow_blank: true

end
