defmodule RemoteJobs.Core.JobFlow do
  @moduledoc """
  This module represents the main flows
  """
  use Rop
  alias RemoteJobs.EmailManager
  alias RemoteJobs.JobOperator
  alias RemoteJobs.PaymentOperator
  alias RemoteJobs.UploadOperator

  def publish_job(job_from_view) do
    job_from_view
    |> UploadOperator.up_img_to_cloudinary()
    >>> JobOperator.create_job(job_from_view)
    >>> PaymentOperator.pay_for_publish()
    >>> JobOperator.update_paid_job()
    >>> bind(try_catch(EmailManager.send_confirmation()))
  end

end
