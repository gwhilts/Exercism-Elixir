defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    Enum.reduce(opts, %Queens{}, &add_queen/2)
  end

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
  end

  #### private ####

  #spec add_queen({atom, {integer, integer}}, Queens.t()) :: Queens.t()
  defp add_queen({color, {row, col}}, queens) do
    if valid_queen?({color, {row, col}}, queens) do
      %{queens | color => {row, col}}
    else
      raise ArgumentError
    end
  end

  #spec squar_char({integer, integer}, Queens.t()) :: "_" | "B" | "W"
  defp square_char(square, queens) do
    w = queens.white
    b = queens.black
    case square do
      ^w -> "W"
      ^b -> "B"
      _ -> "_"
    end
  end

  #spec valid_queen?({atom, {pos_integer, pos_integer}}, Queens.t()) :: boolean
  defp valid_queen?({color, {row, col}}, queens) do
    color in [:white, :black]
    && row in 0..7
    && col in 0..7
    && !({row, col} in Map.values(queens))
  end
end
