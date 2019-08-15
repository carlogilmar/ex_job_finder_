defmodule RemoteJobs.SuscriptorOperator do
  @moduledoc """
    This module is for access to the
    storage of suscritor schema
  """
  alias RemoteJobs.Repo
  alias RemoteJobs.Suscriptor

  def create(email, name) do
    %Suscriptor{}
    |> Suscriptor.changeset(%{name: name, email: email})
    |> Repo.insert()
  end

  def find_all do
    Suscriptor |> Repo.all()
  end
end
