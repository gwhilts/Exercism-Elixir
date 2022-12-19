defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, _workers) do
    Enum.join(texts)
    |> String.downcase()
    |> String.replace(~r/[^a-zà-ÿ]/, "")
    |> String.codepoints()
    |> Enum.frequencies()
  end
end
