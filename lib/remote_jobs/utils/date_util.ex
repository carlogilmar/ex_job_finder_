defmodule RemoteJobs.DateUtil do
  @moduledoc """
    Functions for make date operations
  """

  @valid_dates 30
  def get_expired_date, do: Date.add(NaiveDateTime.utc_now(), @valid_dates)
  def get_expired_date(date_created), do: Date.add(date_created, @valid_dates)

  def is_expired(current_date, expire_date) do
    comparation = Date.compare(expire_date, current_date)
    expired_validation.(comparation)
  end

  defp expired_validation do
    fn
      :gt -> false
      :lt -> true
      :eq -> true
    end
  end

  defp get_months do
    [
      enero: {1, "01"},
      febrero: {2, "02"},
      marzo: {3, "03"},
      abril: {4, "04"},
      mayo: {5, "05"},
      junio: {6, "06"},
      julio: {7, "07"},
      agosto: {8, "08"},
      septiembre: {9, "09"},
      octubre: {10, "10"},
      noviembre: {11, "11"},
      diciembre: {12, "12"}
    ]
  end

  defp get_spanish_month(description) do
    {month, {_, _}} =
      get_months()
      |> Enum.find(fn {_, {_, string_number}} -> string_number == description end)

    Atom.to_string(month)
  end

  def convert_to_spanish_date(date) when byte_size(date) == 10 do
    <<y1::8, y2::8, y3::8, y4::8,
      _::8, m1::8, m2::8,
      _::8, d1::8, d2::8>> = date
    spanish_month = get_spanish_month(<<m1>> <> <<m2>>)

    <<d1>> <>
      <<d2>> <>
      " de " <>
      "#{spanish_month}" <>
      " del " <> <<y1>> <> <<y2>> <> <<y3>> <> <<y4>>
  end

  def convert_to_spanish_date_and_hour(date) do
    <<y1::8, y2::8, y3::8, y4::8, _::8, m1::8, m2::8,
      _::8, d1::8, d2::8, _::8, hr1::8, hr2::8,
      _::8, min1::8, min2::8, _::8, _seg1::8, _seg2::8>> = date

    date =
      <<y1>> <>
        <<y2>> <>
        <<y3>> <>
        <<y4>> <>
        "-" <> <<m1>> <> <<m2>> <> "-" <> <<d1>> <> <<d2>>

    spanish_date = convert_to_spanish_date(date)
    "#{spanish_date} " <> <<hr1>> <> <<hr2>> <> ":" <> <<min1>> <> <<min2>> <> " hrs"
  end
end
