defmodule RemoteJobs.EmailManager do
  alias RemoteJobs.Email
  alias RemoteJobs.Mailer
	alias RemoteJobs.BuilderUtil
  @confirmation "Remote Jobs: ¡Tu vacante ha sido procesada!"
  @confirmation_template "templates/confirmation.html"

  def send_confirmation(email) do
		body = BuilderUtil.build_email(@confirmation_template)
    Email.build(email, @confirmation, body) |> Mailer.deliver_now()
  end

end
