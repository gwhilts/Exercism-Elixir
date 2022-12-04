defmodule Matrix do
  # Don't know if this was cheating, but I just used a nested
  # list instead of the %Matrix{} struct suggested. It required
  # much less foofing around. Also, note that this code assumes
  # each row has an equal number of columns, but so did the tests
  # so I didn't worry about working around that.

  def columns(matrix), do: for col <- 1..length(Enum.at(matrix, 0)), do: column(matrix, col)
  def column(matrix, index), do: for row <- matrix, do: Enum.at(row, index - 1)
  def from_string(input), do: String.split(input, "\n") |> Enum.map(&to_ints/1)
  def row(matrix, index), do: Enum.at matrix, (index - 1)
  def rows(matrix), do: matrix
  def to_string(matrix), do: Enum.map(matrix, & (Enum.join &1, " ")) |> Enum.join("\n")

  # private
  defp to_ints(string), do: String.split(string) |> Enum.map(&String.to_integer/1)
end
