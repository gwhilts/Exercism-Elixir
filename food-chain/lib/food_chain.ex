defmodule FoodChain do
  @critters %{
      1 => %{name: "fly", extra: "", verse: ""},
      2 => %{name: "spider", extra: " that wriggled and jiggled and tickled inside her", verse: "\nIt wriggled and jiggled and tickled inside her."},
      3 => %{name: "bird", extra: "", verse: "\nHow absurd to swallow a bird!"},
      4 => %{name: "cat", extra: "", verse: "\nImagine that, to swallow a cat!"},
      5 => %{name: "dog", extra: "", verse: "\nWhat a hog, to swallow a dog!"},
      6 => %{name: "goat", extra: "", verse: "\nJust opened her throat and swallowed a goat!"},
      7 => %{name: "cow", extra: "", verse: "\nI don't know how she swallowed a cow!"}
    }

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: Enum.map_join(start..stop, "\n", &recite_verse/1)

  defp recite_verse(8), do: "I know an old lady who swallowed a horse.\nShe's dead, of course!\n"
  defp recite_verse(v), do: "I know an old lady who swallowed a #{@critters[v].name}.#{@critters[v].verse}\n" <> count_down_from(v)

  defp count_down_from(v), do: Enum.map(v..1, &link/1) |> Enum.join("\n")

  defp link(1), do: "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  defp link(v), do: "She swallowed the #{@critters[v].name} to catch the #{@critters[v - 1].name <> @critters[v - 1].extra}."
end
