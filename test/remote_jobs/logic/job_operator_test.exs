defmodule RemoteJobs.JobOperatorTest do
  use ExUnit.Case
  alias RemoteJobs.JobOperator

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RemoteJobs.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(RemoteJobs.Repo, {:shared, self()})
  end

  test "CRU of simple job" do
    # Create
    job = %{"position" => "dev", "primary_tag" => ["tag"], "extra_tags" => ["ui"]}
    {create_resp, job_created} = JobOperator.create_job("src.com", job)
		# Read
		job_stored = JobOperator.find(job_created.id)
		# Updated
		{:ok, job_updated} = JobOperator.update_paid_job(%{:job => job_stored, :order_id => "order_id47d73784h"})
		# Find all
		jobs_paid = JobOperator.find_all_paid_jobs()
		# Delete job
		job_deleted = JobOperator.delete(job_updated)
    assert :ok == create_resp
		assert job_stored.id == job_created.id
		assert job_updated.status == "PAID"
		assert length(jobs_paid) > 0
		assert job_deleted == :ok
  end

	test "Get a list of jobs" do
    jobs = JobOperator.find_all("PAID")
		assert jobs != nil
	end
end
