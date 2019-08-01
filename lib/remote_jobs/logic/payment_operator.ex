defmodule RemoteJobs.PaymentOperator do
  @moduledoc """
    This module is for implement the payment
    when someone create a job
  """
  alias RemoteJobs.JobOperator

  def pay_for_publish(job_created, _card) do
    # Implement payment
    payment = {:ok, job_created}
    validate_payment.(payment)
  end

  def validate_payment do
    fn
      {:error, job_created} ->
        _job_deleted = JobOperator.delete(job_created)
        {:error, %{message: "Payment Operator, pago inválido, no se procesó la vacante"}}
      success -> success
    end
  end
end
