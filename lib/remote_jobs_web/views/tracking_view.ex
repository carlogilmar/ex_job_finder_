defmodule RemoteJobsWeb.TrackingView do
  use RemoteJobsWeb, :view

  def get_date(date), do: NaiveDateTime.to_string(date)
end
