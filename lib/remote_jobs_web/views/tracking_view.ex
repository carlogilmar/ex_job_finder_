defmodule RemoteJobsWeb.TrackingView do
  use RemoteJobsWeb, :view
  alias RemoteJobs.DateUtil

  def get_date(date) do
    date_parsed = NaiveDateTime.to_string(date)
    DateUtil.convert_to_spanish_date_and_hour(date_parsed)
  end
end
