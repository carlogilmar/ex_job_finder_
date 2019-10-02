defmodule RemoteJobs.Guardian do
  @moduledoc false
  use Guardian, otp_app: :remote_jobs

  def subject_for_token(user, _claims) do
    #{:ok, token, guardian} = user
    {:ok, 1}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = %{username: "guardian toy papa"}
    {:ok,  resource}
  end
end
