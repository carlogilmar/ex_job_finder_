defmodule RemoteJobs.EmailManager do
  @moduledoc """
    This module is for send emails with attached file
  """
  alias RemoteJobs.DateUtil
  alias RemoteJobs.Email
  alias RemoteJobs.FileUtil
  alias RemoteJobs.Mailer
  @confirmation_email_template "templates/confirmation.html"
  @confirmation_pdf_template "templates/pdf.html"

  def send_confirmation(job_created) do
    date =
      job_created.expire_date
      |> Date.to_string()
      |> DateUtil.convert_to_spanish_date()

    email_attrs = [
      company_name: job_created.company_name,
      position: job_created.position,
      url: job_created.url,
      logo_url: job_created.logo,
      expire_date: date
    ]

    send_email_and_pdf(job_created.email, job_created.position, email_attrs)
  end

  def send_email_and_pdf(email, position, attrs) do
    builders = [
      {FileUtil.build_email(), {@confirmation_email_template, attrs}},
      {FileUtil.build_pdf(), {@confirmation_pdf_template, attrs}}
    ]

    [email_body, email_pdf] =
      builders
      |> Enum.map(fn {builder, args} -> apply_execution(builder, args) end)
      |> Enum.map(fn builder -> Task.async(builder) end)
      |> Enum.map(fn task -> Task.await(task, 9000) end)

    email
    |> Email.build_with_attach(
      "RemoteJobs: ¡La vacante #{position} ha sido procesada!",
      email_body,
      email_pdf
    )
    |> Mailer.deliver_now()
  end

  defp apply_execution(fun, args), do: fn -> fun.(args) end
end
