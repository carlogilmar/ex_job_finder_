defmodule RemoteJobsWeb.ApprovePreviewView do
  use RemoteJobsWeb, :view
  def show_status(status) do
    case status do
      "CREATED" -> "<span style='margin-top: 3px;' class='float-right badge badge-info'>Por Autorizar</span>"
      "UNAVAILABLE" -> "<span style='margin-top: 3px;' class='float-right badge badge-warning'>No Disponible</span>"
      "AVAILABLE" -> "<span style='margin-top: 3px;' class='float-right badge badge-success'>Disponible</span>"
      "EXPIRED" -> "<span style='margin-top: 3px;' class='float-right badge badge-secondary'>Expirado</span>"
    end
  end
end
