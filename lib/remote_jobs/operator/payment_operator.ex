defmodule RemoteJobs.PaymentOperator do
  @moduledoc """
    This module is for implement the payment
    when someone create a job
  """
  alias RemoteJobs.JobOperator
  alias Payments.Methods.Adapters.Conekta
  require Logger

  def pay_for_publish(job) do
    with {:ok, created_order} <- Conekta.create_card_order_with_token(job.name, job.email, job.card_token) do
      Logger.info("\n ::Job Tracker:: Job paid successfully, ORDER ID #{created_order.id} ->\n")
      validate_payment.({
        :ok,
        %{job: job, 
          order_id: created_order.id}
      })
    else {:error, e = %ConektaError{}} ->
      Logger.info("\n ::Job Tracker:: Job payment failed ERROR: #{e.message}  \n")
      validate_payment.({:error, job})
    end
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
