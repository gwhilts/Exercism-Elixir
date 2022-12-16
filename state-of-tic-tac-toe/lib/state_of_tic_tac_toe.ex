defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    paths = parse(board)
    err_msg = validate(paths)

    cond do
      err_msg -> {:error, err_msg}
      win?(paths) -> {:ok, :win}
      draw?(paths) -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
  end

  # Private

  defp draw?(paths), do: List.flatten(paths) |> Enum.all?(& &1 in ["X", "O"]) # and !(win?(paths)) # i.e. check win?/1 first

  defp freqs(paths) do
    f = List.flatten(paths) |> Enum.frequencies
    {(f["X"] || 0), (f["O"] || 0)}
  end

  defp kept_playing?(paths), do: o_win?(paths) and x_win?(paths)

  defp o_first?({x, o}), do: o > x

  defp o_win?(paths), do: ["O", "O", "O"] in paths

  defp parse(board) do
    rows = String.split(board, "\n", trim: true) |> Enum.map(&String.codepoints/1)
    cols = for i <- 0..2, do: [Enum.at(Enum.at(rows, 0), i), Enum.at(Enum.at(rows, 1), i), Enum.at(Enum.at(rows, 2), i)]
    fd = for i <- 0..2, do: Enum.at(Enum.at(rows, i), i)
    rd = for i <- 0..2, do: Enum.at(Enum.at(rows, i), (2-i))
    rows ++ cols ++ [fd] ++ [rd]
  end

  defp validate(paths) do
    f = freqs(Enum.take(paths, 3))
    cond do
      x_twice?(f) -> "Wrong turn order: X went twice"
      o_first?(f) -> "Wrong turn order: O started"
      kept_playing?(paths) -> "Impossible board: game should have ended after the game was won"
      true -> nil
    end
  end

  defp win?(paths), do: x_win?(paths) or o_win?(paths)

  defp x_twice?({x, o}), do: x - o > 1

  defp x_win?(paths), do: ["X", "X", "X"] in paths
end
