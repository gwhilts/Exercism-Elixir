defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &(key_for(&1) == key_for(base)))
    |> Enum.reject(&(String.upcase(&1) == String.upcase(base)))
  end

  # "Tar" -> 'ART', "rat" -> 'ART', "aRt" -> 'ART'
  defp key_for(word) do
    String.upcase(word) |> String.to_charlist() |> Enum.sort()
  end

end
