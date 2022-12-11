defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []), do: Enum.reduce(opts, %Queens{}, &add_queen/2)

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    (for r <- 0..7, c <- 0..7, do: square_char({r, c}, queens))
    |> Enum.chunk_every(8)
    |> Enum.map(& Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    if queens.white == nil or queens.black == nil do
      false
    else
      attack_col?(queens)
      or attack_row?(queens)
      or attack_r_diag?(queens)
      or attack_l_diag?(queens)
    end
  end


  #### private ####

  # add_queen({atom, {integer, integer}}, Queens.t()) :: Queens.t()
  defp add_queen({color, {row, col}}, queens) do
    if valid_queen?({color, {row, col}}, queens) do
      %{queens | color => {row, col}}
    else
      raise ArgumentError
    end
  end

  # attack_*?(Queens.t()) :: boolean
  defp attack_col?(queens), do: elem(queens.black, 1) == elem(queens.white, 1)
  defp attack_row?(queens), do: elem(queens.black, 0) == elem(queens.white, 0)
  defp attack_l_diag?(queens), do: (elem(queens.black, 0) - elem(queens.black, 1)) == (elem(queens.white, 0) - elem(queens.white, 1))
  defp attack_r_diag?(queens), do: (elem(queens.black, 0) + elem(queens.black, 1)) == (elem(queens.white, 0) + elem(queens.white, 1))


  # square_char({integer, integer}, Queens.t()) :: "_" | "B" | "W"
  defp square_char(square, queens) do
    w = queens.white
    b = queens.black
    case square do
      ^w -> "W"
      ^b -> "B"
      _ -> "_"
    end
  end

  # valid_queen?({atom, {pos_integer, pos_integer}}, Queens.t()) :: boolean
  defp valid_queen?({color, {row, col}}, queens) do
    color in [:white, :black]
    and row in 0..7
    and col in 0..7
    and !({row, col} in Map.values(queens))
  end
end
