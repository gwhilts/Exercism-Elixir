defmodule FoodChain do
  @critters %{
    1 => %{name: "fly", descr: "", verse: ""},
    2 => %{name: "spider", descr: " that wriggled and jiggled and tickled inside her", verse: "It wriggled and jiggled and tickled inside her.\n"},
    3 => %{name: "bird", descr: "", verse: "How absurd to swallow a bird!\n"},
    4 => %{name: "cat", descr: "", verse: "Imagine that, to swallow a cat!\n"},
    5 => %{name: "dog", descr: "", verse: "What a hog, to swallow a dog!\n"},
    6 => %{name: "goat", descr: "", verse: "Just opened her throat and swallowed a goat!\n"},
    7 => %{name: "cow", descr: "", verse: "I don't know how she swallowed a cow!\n"}
  }

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: Enum.map_join(start..stop, "\n", &recite_verse/1)

  defp recite_verse(8), do: "I know an old lady who swallowed a horse.\nShe's dead, of course!\n"
  defp recite_verse(v), do: "I know an old lady who swallowed a #{@critters[v].name}.\n#{@critters[v].verse}" <> count_down_from(v)

  defp count_down_from(v), do: Enum.map_join(v..1, "\n", &link/1)

  defp link(1), do: "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  defp link(v), do: "She swallowed the #{@critters[v].name} to catch the #{@critters[v - 1].name <> @critters[v - 1].descr}."
end
