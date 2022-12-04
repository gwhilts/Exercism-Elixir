defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    String.downcase(sentence)
    |> String.to_charlist()
    |> Enum.filter(&(&1 in ?a..?z))
    |> (& &1 == Enum.uniq &1).()
  end
end
