defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @wday %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}
  @base_day %{first: 1, second: 8, teenth: 13, third: 15, fourth: 22}

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, :last), do:
    Date.new!(year, month, 1) |> Date.end_of_month() |> prev_weekday(weekday)

  def meetup(year, month, weekday, schedule), do:
    Date.new!(year, month, @base_day[schedule]) |> next_weekday(weekday)

  defp ahead(wday1, wday2) when wday1 <= wday2, do: wday2 - wday1
  defp ahead(wday1, wday2), do: (7 - wday1) + wday2

  defp back(wday1, wday2) when wday1 >= wday2, do: wday2 - wday1
  defp back(wday1, wday2), do: (wday2 - 7) - wday1

  defp next_weekday(date, weekday), do: Date.add(date, ahead(Date.day_of_week(date), @wday[weekday]))

  defp prev_weekday(date, weekday), do: Date.add(date, back(Date.day_of_week(date), @wday[weekday]))
end
