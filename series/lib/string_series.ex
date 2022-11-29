defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size <= 0, do: []
  def slices(s, size) do
    String.codepoints(s)
    |> to_slices([], size)
    |> Enum.map(&Enum.join/1)
  end

  defp to_slices(list, slices, size) when length(list) < size, do: slices |> Enum.uniq()
  defp to_slices(list, slices, size) do
    to_slices(tl(list), slices ++ Enum.chunk_every(list, size, 1, :discard), size)
  end
end
