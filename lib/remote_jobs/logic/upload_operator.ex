defmodule RemoteJobs.UploadOperator do
  @moduledoc """
  A module for upload img to cloudinary
  """
  alias RemoteJobs.RequestManager

  def up_img_to_cloudinary(img_encoded_base64) do
    preset =
      Application.get_env(
        :remote_jobs,
        RemoteJobsWeb.Endpoint
      )[:cloudinary_preset]

    url =
      Application.get_env(
        :remote_jobs,
        RemoteJobsWeb.Endpoint
      )[:cloudinary_url]

    params = %{file: img_encoded_base64, upload_preset: preset}
    res = RequestManager.post(url, params, [{"Content-Type", "application/json"}])
    res["url"]
  end
end
