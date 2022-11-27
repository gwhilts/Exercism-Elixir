defmodule ResistorColorDuo do
  @colors [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([c1, c2 | _tail]), do: code(c1) * 10 + code(c2)
  defp code(color), do: Enum.find_index(@colors, &(color == &1))
end
