defmodule RemoteJobs.DateUtilTest do
  use ExUnit.Case
  alias RemoteJobs.DateUtil

  test "Get the expire date" do
    job_date_created = ~N[2019-07-10 20:47:07.941295]
    job_expired_date = DateUtil.get_expired_date(job_date_created)
    assert job_expired_date == ~D[2019-08-09]
  end
end
