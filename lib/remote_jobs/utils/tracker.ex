defmodule RemoteJobs.Tracker do
  alias RemoteJobs.TrackerManager

  @moduledoc """
    This module is for track important operations
    description you can use it with preview descriptions
    or you can use with your own description
    check the arity below:

    iex> RemoteJobs.Tracker.track_operation({:job_created, "author"})

    iex> RemoteJobs.Tracker.track_operation("author", "description not writted")
  """

  def track_operation({atom_track, author}) do
    add_state_change_tracked.({atom_track, author, "not_description"})
  end

  def track_operation(author, description) do
    add_state_change_tracked.({:track, author, description})
  end

  defp add_state_change_tracked do
    fn
      {:try_create_job, author, _desc} ->
        TrackerManager.create(author, "Intentó dar de alta una vacante")

      {:job_created, author, _desc} ->
        TrackerManager.create(author, "Se creó vacante sin ser publicada")

      {:job_published, author, _desc} ->
        TrackerManager.create(author, "Se procesó pago, una vacante ha sido publicada")

      {:payment_rejected, author, _desc} ->
        TrackerManager.create(author, "No se procesó pago, la vacante
                                       correspondiente no fue publicada")

      {:check_expiration, author, _desc} ->
        TrackerManager.create(author, "Revisando vacantes que ya expiraron")

      {:track, author, desc} ->
        TrackerManager.create(author, desc)
    end
  end
end
