defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.map(factors, &(multiples_of &1, limit)) |> List.flatten()
    |> Enum.uniq()
    |> Enum.sum()
  end

  defp multiples_of(0, _), do: [0]
  defp multiples_of(factor, limit) do
    Stream.unfold(factor, fn(n) -> {n, n + factor} end)
    |> Enum.reduce_while([], fn n, list -> if n < limit, do: {:cont, [n | list]}, else: {:halt, list} end)
  end

  # There's probably a shorter way to do this using a .reduce over the range 0..limit but this way seemed
  # simple and clear: List all the multiples of each factor up to the limit, remove dups, add 'em up.
end
