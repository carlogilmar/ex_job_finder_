defmodule RemoteJobs.UploadOperator do
  @moduledoc """
  A module for upload img to cloudinary
  """
  alias RemoteJobs.RequestManager

  def up_img_to_cloudinary(job_from_view) do
    img_encoded_base64 = job_from_view["logo"]

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
    content_type = [{"Content-Type", "application/json"}]

    url
    |> RequestManager.post(params, content_type)
    |> validate_cloudinary_url.()
  end

  def validate_cloudinary_url do
    fn
      :unknown_error ->
        {:error,
         %{
           message:
             " Cloudinary error: Ocurrió un error desconocido al subir logo al servicio de storage. No se creó la vacante."
         }}

      :client_error ->
        {:error,
         %{
           message:
             " Cloudinary error: Hubó errores al conectar con el servicio de storage. No se creó la vacante."
         }}

      body ->
        {:ok, body["url"]}
    end
  end
end
