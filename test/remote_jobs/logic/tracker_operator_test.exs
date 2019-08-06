defmodule RemoteJobs.TrackerOperatorTest do
  use ExUnit.Case
  alias RemoteJobs.TrackerOperator
  alias RemoteJobs.JobOperator

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RemoteJobs.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(RemoteJobs.Repo, {:shared, self()})
  end

  test "Check tracker lifecycle" do
    fake_job = %{"position" => "dev", "primary_tag" => ["tag"], "extra_tags" => ["ui"]}
    {:ok, job} = JobOperator.create_job("src.com", fake_job)
    track = TrackerOperator.create(job, "Testing tracker")
    tracking  = TrackerOperator.get_tracking()
    assert length(tracking) > 0
    assert track.description == "Testing tracker"
  end

end
