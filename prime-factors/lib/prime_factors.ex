defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(num), do: factors_for(num, 2, []) |> Enum.sort

  defp factors_for(1, _, acc), do: acc
  defp factors_for(num, maybe, acc) when rem(num, maybe) == 0, do: factors_for(div(num, maybe), maybe, [maybe | acc])
  defp factors_for(num, maybe, acc), do: factors_for(num, maybe + 1, acc)
end
