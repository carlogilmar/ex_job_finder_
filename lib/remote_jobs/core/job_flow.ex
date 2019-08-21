defmodule RemoteJobs.Core.JobFlow do
  @moduledoc """
  This module represents the main flows

  This module is using Railway through ROP macro

  Review https://hexdocs.pm/rop/readme.html for more details

  Rop pipe: >>>
  Rop binding: bind(fun)
  Rop Try Catch: try_catch(fun)
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
