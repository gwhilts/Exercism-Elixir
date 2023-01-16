defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit), do: sift(Enum.to_list(2..limit), [])

  defp sift([p | []], primes), do: Enum.reverse([p | primes])
  defp sift([p | tail], primes), do: sift(filter_multiples(p, tail), [p | primes])

  defp filter_multiples(base, list), do: list -- Enum.to_list((base * 2)..List.last(list)//base)
end
