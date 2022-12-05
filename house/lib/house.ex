defmodule House do
  @items [
    "the malt that lay",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to"
  ]

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: (for n <- start..stop, do: verse(n)) |> Enum.join()

  # private

  defp verse(1), do: "This is the house that Jack built.\n"
  defp verse(num), do: "This is " <> middle(num) <> " in the house that Jack built.\n"

  defp middle(n), do: Enum.take(@items, n - 1) |> Enum.reverse() |> Enum.join(" ")
end
