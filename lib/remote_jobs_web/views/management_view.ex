defmodule RemoteJobsWeb.ManagementView do
  use RemoteJobsWeb, :view
  alias RemoteJobs.DateUtil

  def get_date(date) do
    date_parsed = NaiveDateTime.to_string(date)
    DateUtil.convert_to_spanish_date_and_hour(date_parsed)
  end

  def show_status(status) do
    case status do
      "CREATED" -> "<span class='badge badge-info'>Por Autorizar</span>"
      "UNAVAILABLE" -> "<span class='badge badge-warning'>No Disponible</span>"
      "AVAILABLE" -> "<span class='badge badge-success'>Disponible</span>"
      "EXPIRED" -> "<span class='badge badge-secondary'>Expirado</span>"
    end
  end
end
