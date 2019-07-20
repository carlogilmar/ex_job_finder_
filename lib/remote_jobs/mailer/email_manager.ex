defmodule RemoteJobs.EmailManager do
  alias RemoteJobs.Email
  alias RemoteJobs.Mailer
	alias RemoteJobs.BuilderUtil
  @confirmation "Remote Jobs: ¡Tu vacante ha sido procesada!"
  @confirmation_template "templates/confirmation.html"

  def send_confirmation(email) do
		body = BuilderUtil.build_email(@confirmation_template)
    pdf_src = BuilderUtil.build_pdf(@confirmation_template)
    Email.build_with_attach(email, @confirmation, body, pdf_src) |> Mailer.deliver_now()
  end

end
