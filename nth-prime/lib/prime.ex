defmodule Prime do
  # Guessing there's a faster way to do this, but brain is failing me at the moment.

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: nth(2, 0, count)
  defp nth(num, stop, stop), do: num - 1
  defp nth(num, count, stop), do: if prime?(num), do: nth(num + 1, count+1, stop), else: nth(num + 1, count, stop)

  defp prime?(num) when num in [1, 2, 3], do: true
  defp prime?(num), do: Enum.reduce(2..(div(num, 2)), true, &(rem(num, &1) != 0 and &2 ))
end
