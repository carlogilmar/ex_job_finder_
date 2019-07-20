defmodule RemoteJobs.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def build(email, subject, body) do
    new_email()
    |> to(email)
    |> from("confirmation@remotejobs.io")
    |> subject(subject)
    |> html_body(body)
  end
end
