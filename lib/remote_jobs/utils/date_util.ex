defmodule RemoteJobs.DateUtil do
  @moduledoc """
    Functions for make date operations
  """

  @valid_dates 30
  def get_expired_date, do: Date.add(NaiveDateTime.utc_now(), @valid_dates)
  def get_expired_date(date_created), do: Date.add(date_created, @valid_dates)

  def is_expired(current_date, expire_date) do
    comparation = Date.compare(expire_date, current_date)
    expired_validation.(comparation)
  end

  defp expired_validation do
    fn
      :gt -> false
      :lt -> true
      :eq -> true
    end
  end
end
