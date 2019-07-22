defmodule RemoteJobs.EmailManager do
  alias RemoteJobs.Email
  alias RemoteJobs.Mailer
	alias RemoteJobs.FileUtil
  @confirmation "Remote Jobs: ¡Tu vacante ha sido procesada!"
  @confirmation_email_template"templates/confirmation.html"
  @confirmation_pdf_template "templates/confirmation.html"

  def send_confirmation(email) do
    builders = [{FileUtil.build_email, @confirmation_email_template},
                {FileUtil.build_pdf, @confirmation_email_template}]

    [email_body, email_pdf] =
      builders
        |> Enum.map(fn {builder, args} -> apply_execution(builder, args) end)
        |> Enum.map(fn builder -> Task.async(builder) end)
        |> Enum.map(fn task-> Task.await(task, 9000) end)

    Email.build_with_attach(email, @confirmation, email_body, email_pdf) |> Mailer.deliver_now()
  end

  defp apply_execution(fun, args), do: fn -> fun.(args) end

end
