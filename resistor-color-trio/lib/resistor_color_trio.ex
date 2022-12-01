defmodule ResistorColorTrio do
  @colors [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    ohms = value(colors)
    if ohms < 1000, do: {ohms, :ohms}, else: {div(ohms, 1000), :kiloohms}
  end

  defp code(color), do: Enum.find_index(@colors, &(color == &1))
  defp value([c1, c2, c3 | _tail]), do: (code(c1) * 10 + code(c2)) * 10 ** code(c3)

end
