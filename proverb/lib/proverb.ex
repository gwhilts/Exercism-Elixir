defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([word]), do: finale(word)
  def recite(strings = [first | _]), do: lines(strings) <> "\n" <> finale(first)

  defp finale(word), do: "And all for the want of a #{word}.\n"

  defp lines(strings), do:
    (for i <- 0..(length(strings) - 2), do: "For want of a #{Enum.at(strings, i)} the #{Enum.at(strings, i + 1)} was lost.")
    |> Enum.join("\n")
end
