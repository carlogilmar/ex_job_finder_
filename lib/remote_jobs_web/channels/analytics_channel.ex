defmodule RemoteJobsWeb.AnalyticsChannel do
  @moduledoc """
    A module in charge of the analytics channel.
  """
  use Phoenix.Channel

  def join("analytics:join", _msg, socket) do
    analytics = get_analytics_series()
    {:ok, analytics, socket}
  end

  def get_analytics_series() do
    [
      %{name: "23 - 00",
        data: [
          %{x: "Domingo", y: 90},
          %{x: "Lunes", y: 90},
          %{x: "Martes", y: 90},
          %{x: "Miércoles", y: 90},
          %{x: "Jueves", y: 90},
          %{x: "Viernes", y: 150},
          %{x: "Sábado", y: 100}
        ]
      }
    ]
  end

end
