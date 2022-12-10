defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    # Enum.reduce(opts, %Queens{}, fn(opt, queens) -> add_queen(opt, queens) end)
    Enum.reduce(opts, %Queens{}, &add_queen/2)
  end

  # def add_queen(q, [color => {row, coll}]) when color in [:red, :white] and row in 1..8 and col in 1..8 do

  # end

  @spec add_queen({atom, {pos_integer, pos_integer}}, %Queens{}) :: %Queens{}
  def add_queen({color, {row, col}}, queens) do
    if valid_queen?({color, {row, col}}, queens) do
      %{queens | color => {row, col}}
    else
      raise ArgumentError
    end
  end

  def valid_queen?({color, {row, col}}, queens) do
    color in [:white, :black]
    && row in 0..7
    && col in 0..7
    && !({row, col} in Map.values(queens))
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
  end
end
