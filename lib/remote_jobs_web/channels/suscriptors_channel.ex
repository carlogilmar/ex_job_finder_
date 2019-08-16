defmodule RemoteJobsWeb.SuscriptorsChannel do
  @moduledoc """
    A module in charge of the suscriptor channel.
  """

  use Phoenix.Channel
  alias RemoteJobs.SuscriptorOperator

  def join("suscriptor:channel", _msg, socket) do
    {:ok, [], socket}
  end

  def handle_in("suscriptor:create", %{"email" => email, "name" => name}, socket) do
    {res, _msg} = SuscriptorOperator.create(email, name)
    {:reply, {res, %{}}, socket}
  end
end
