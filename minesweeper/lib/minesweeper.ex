defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate([]), do: []
  def annotate([""]), do: [""]
  def annotate(board) do
    grid = Enum.map(board, &String.codepoints/1)
    {w, h} = {length(grid), length(List.first(grid))}
    (for row <- 0..(w - 1), col <- 0..(h - 1), do: check_point {row, col}, grid)
    |> separate_rows(w, h)
    |> Enum.map(&List.to_string/1)
    |> Enum.map(& String.replace(&1, "0", " "))
  end

  # Private

  defp check_above({row, col}, grid) do
    case row do
      0 -> 0
      n -> check_row({n - 1, col}, grid)
    end
  end

  defp check_below({row, col}, grid) do
    last = length(grid) - 1
    case row do
      ^last -> 0
      n -> check_row({n + 1, col}, grid)
    end
  end

  # Note: Only call on an empty square. Calling on a square
  # containing a mine will include itself in the count.
  defp check_point({row, col}, grid) do
    if (Enum.at(grid, row) |> Enum.at(col)) == "*" do
      "*"
    else
      check_row({row, col}, grid) + check_above({row, col}, grid) + check_below({row, col}, grid)
      |> Integer.to_string()
    end
  end

  defp check_row({row, col}, grid) do
    case col do
      0 -> Enum.slice(Enum.at(grid, row), 0, 2)
      n -> Enum.slice(Enum.at(grid, row), n - 1, 3)
    end
    |> Enum.filter(& &1 == "*") |> Enum.count()
  end

  defp separate_rows(flat_grid, height, width), do: if height == 1, do: [flat_grid], else: Enum.chunk_every(flat_grid, width)

end
