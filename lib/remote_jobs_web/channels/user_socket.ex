defmodule RemoteJobsWeb.UserSocket do
  use Phoenix.Socket

  channel "remote:*", RemoteJobsWeb.JobsChannel
  channel "suscriptor:*", RemoteJobsWeb.SuscriptorsChannel
  channel "updt_job:*", RemoteJobsWeb.UpdtJobChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
