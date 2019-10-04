defmodule RemoteJobsWeb.AnalyticsChannel do
  @moduledoc """
    A module in charge of the analytics channel.
  """
  use Phoenix.Channel
  alias RemoteJobs.AnalyticsUtil

  def join("analytics:join", _msg, socket) do
    analytics = AnalyticsUtil.get_analytics()
    {:ok, analytics, socket}
  end

end
