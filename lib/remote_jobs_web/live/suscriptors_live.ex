defmodule RemoteJobsWeb.SuscriptorsLive do
  @moduledoc """
    Module for implement live view for show the suscriptors
  """
  use Phoenix.LiveView
  alias RemoteJobsWeb.SuscriptorsView
  alias RemoteJobs.SuscriptorOperator

  def render(assigns) do
    SuscriptorsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    suscriptors = SuscriptorOperator.find_all()
    socket =
      socket
      |> assign(:suscriptors, suscriptors)

    {:ok, socket}
  end

end
