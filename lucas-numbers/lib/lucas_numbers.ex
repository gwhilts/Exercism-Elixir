defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite seriesuence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  def generate(series \\ [], count) do
    unless is_integer(count), do: raise ArgumentError, "count must be specified as an integer >= 1"
    unless count >= 1, do: raise ArgumentError, "count must be specified as an integer >= 1"
    if Enum.count(series) >= count do
      Enum.reverse series
    else
      generate([next_in(series) | series], count)
    end
  end

  defp next_in(series) do
    case Enum.count(series) do
      0 -> 2
      1 -> 1
      _ -> sum_of_first_two(series)
    end
  end

  defp sum_of_first_two(series) do
    [a, b | _] = series
    a + b
  end

end
