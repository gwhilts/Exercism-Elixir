defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence), do: word_list(sentence) |> Enum.frequencies()

  defp word_list(sentence) do
    String.downcase(sentence)
    |> String.split(~r/[ \:\._\n,!!&@\$%\^]+/, trim: true)
    |> Enum.map(&(String.trim(&1, "'")))
  end
end
