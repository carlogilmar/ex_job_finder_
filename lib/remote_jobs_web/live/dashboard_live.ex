defmodule RemoteJobsWeb.DashboardLive do

  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h2>Remote Jobs</h2>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
