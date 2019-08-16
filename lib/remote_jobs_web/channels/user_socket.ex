defmodule RemoteJobsWeb.UserSocket do
  use Phoenix.Socket

  channel "remote:*", RemoteJobsWeb.JobsChannel
  channel "suscriptor:*", RemoteJobsWeb.SuscriptorsChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
