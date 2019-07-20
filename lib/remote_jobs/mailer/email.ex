defmodule RemoteJobs.Email do
  import Bamboo.Email

  def build(email, subject, body) do
    new_email()
    |> to(email)
    |> from("confirmation@remotejobs.io")
    |> subject(subject)
    |> html_body(body)
  end

  def build_with_attach(email, subject, body, pdf_path) do
    new_email()
      |> to(email)
      |> from("confirmation@remotejobs.io")
      |> subject(subject)
      |> put_attachment(Bamboo.Attachment.new(pdf_path))
      |> html_body(body)
  end
end
