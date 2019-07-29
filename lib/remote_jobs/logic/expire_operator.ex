defmodule RemoteJobs.ExpireOperator do
  @moduledoc """
  This contains the function for update
  the jobs when someone is expired
  """
  alias RemoteJobs.DateUtil
  alias RemoteJobs.JobManager
  alias RemoteJobs.JobOperator

  def check_paid_jobs_expiration() do
    JobOperator.find_all_paid_jobs()
    |> check_expire_date()
    |> update_expired_jobs()
  end

  defp check_expire_date(jobs) do
    for job <- jobs do
      current_date = Date.utc_today()
      is_expired = DateUtil.is_expired(current_date, job.expire_date)
      {job, is_expired}
    end
  end

  defp update_expired_jobs(jobs),
    do:
      Enum.each(jobs, fn {job, is_expired} ->
        update_expired_job.({job, is_expired})
      end)

  defp update_expired_job do
    fn
      {job, true} ->
        job_updated = JobOperator.update(job, %{status: "EXPIRED"})
        _ = JobManager.update_live_dashboard()
        job_updated

      {job, false} ->
        job

      _error ->
        raise "Expire operator: Ocurrio un error al actualizar vacante expirada"
    end
  end
end
