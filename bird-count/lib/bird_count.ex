defmodule BirdCount do

  # smart:
  # def today(list), do: L*st.first(list)
  # dumb:
  def today([]), do: nil
  def today([h | _tail]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([h | tail]), do: [h+1 | tail]

  # smart
  # def has_day_without_birds?(list), do: Enum.member?(list, 0)
  # dumb:
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  # smart:
  # def total(list), do: E*um.sum list
  # dumb:
  def total([]), do: 0
  def total([h | tail]), do: h + total(tail)

  # smart:
  # def busy_days(list), do: E*um.count(list, &(&1 > 4))
  # dumb:
  def busy_days([]), do: 0
  def busy_days([h | tail]) when h > 4, do: 1 + busy_days(tail)
  def busy_days([_h | tail]), do: busy_days(tail)
end
