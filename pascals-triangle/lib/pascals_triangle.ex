defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: Stream.iterate([1], &next_row/1) |> Enum.take(num)
  defp next_row(prev), do: [1 | (for i <- 0..(length(prev) - 1), do: Enum.at(prev, i) + (Enum.at(prev, i + 1) || 0))]
end
