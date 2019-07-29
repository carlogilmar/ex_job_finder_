defmodule RemoteJobs.Scheduler do
  @moduledoc """
    Scheduler for run the job
  """
  use Quantum.Scheduler,
    otp_app: :remote_jobs
end
