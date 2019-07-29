defmodule RemoteJobs.PaymentOperator do
  @moduledoc """
    This module is for implement the payment
    when someone create a job
  """
  def pay_for_publish(job_created, _card) do
    # Implement payment
    {:ok, job_created}
  end
end
