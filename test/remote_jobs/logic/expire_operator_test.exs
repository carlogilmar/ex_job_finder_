defmodule RemoteJobs.ExpireOperatorTest do
  use ExUnit.Case
  alias RemoteJobs.ExpireOperator
  alias RemoteJobs.JobOperator

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RemoteJobs.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(RemoteJobs.Repo, {:shared, self()})
  end

  test "Running task for check expiration" do
    {job1, job2} = create_jobs_to_be_expired()
    _ = ExpireOperator.check_paid_jobs_expiration()
    job_paid1 = JobOperator.find(job1.id)
    job_paid2 = JobOperator.find(job2.id)
    assert job_paid1.status == "EXPIRED"
    assert job_paid2.status == "EXPIRED"
  end

  defp create_jobs_to_be_expired() do
    fake_job = %{"position" => "dev", "primary_tag" => ["tag"], "extra_tags" => ["ui"]}
    {:ok, job1} = JobOperator.create_job("src.com", fake_job)
    {:ok, job2} = JobOperator.create_job("src.com", fake_job)
    expired_date1 = Date.add(job1.expire_date, -40)
    expired_date2 = Date.add(job2.expire_date, -40)
    {:ok, job_upd1} = JobOperator.update(job1, %{status: "CREATED", expire_date: expired_date1})
    {:ok, job_upd2} = JobOperator.update(job2, %{status: "CREATED", expire_date: expired_date2})
    {job_upd1, job_upd2}
  end

end
