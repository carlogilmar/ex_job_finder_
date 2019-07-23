defmodule RemoteJobs.DateUtil do
  @moduledoc """
    Functions that help job managment.
  """

  @valid_dates 30
  def get_expired_date(), do: Date.add(NaiveDateTime.utc_now(), @valid_dates)
  def get_expired_date(date_created), do: Date.add(date_created, @valid_dates)
end
