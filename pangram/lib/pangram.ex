defmodule Pangram do
  @alphabet 'abcdefghijklmnopqrstuvwxyz'
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    chars = sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(&( &1 >= ?a and &1 <= ?z))
    |> Enum.uniq()
    |> Enum.sort()
    chars == @alphabet

  end
end
