defmodule RemoteJobs.DateUtilTest do
  use ExUnit.Case
  alias RemoteJobs.DateUtil

  test "Get the expire date" do
    job_date_created = ~N[2019-07-10 20:47:07.941295]
    job_expired_date = DateUtil.get_expired_date(job_date_created)
    assert job_expired_date == ~D[2019-08-09]
  end

  [
    {~D[2019-07-29], ~D[2019-06-29], false},
    {~D[2019-07-29], ~D[2019-07-29], true},
    {~D[2019-07-29], ~D[2019-08-01], true}
  ]
  |> Enum.each(fn {expire_date, current_date, expected_status} ->
    @expire_date expire_date
    @current_date current_date
    @expected_status expected_status
    test " Testing if today were: #{@current_date} this job will be..." do
      expired_status = DateUtil.is_expired(@current_date, @expire_date)
      assert expired_status == @expected_status
    end
  end)

  [
    {"2018-12-01", "01 de diciembre del 2018"},
    {"2019-01-12", "12 de enero del 2019"},
    {"2020-06-12", "12 de junio del 2020"}
  ] |> Enum.each(fn {date, expected_date} ->
    @date date
    @expected_date expected_date
    test "Convert date to spanish date #{@date}" do
      date_parsed = DateUtil.convert_to_spanish_date(@date)
      assert date_parsed == @expected_date
    end
  end)

  [
    {"2018-12-01 12:35:00", "01 de diciembre del 2018 12:35 hrs"},
    {"2019-01-12 12:35:00", "12 de enero del 2019 12:35 hrs"},
    {"2020-06-12 12:35:00", "12 de junio del 2020 12:35 hrs"}
  ] |> Enum.each(fn {date, expected_date} ->
    @date date
    @expected_date expected_date
    test "Convert date to spanish date #{@date}" do
      date_parsed = DateUtil.convert_to_spanish_date_and_hour(@date)
      assert date_parsed == @expected_date
    end
  end)

end
