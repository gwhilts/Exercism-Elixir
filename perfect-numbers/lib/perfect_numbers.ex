defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:
  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(1), do: {:ok, :deficient}
  def classify(n) when is_integer(n) and n > 0 do
    aliquot = Enum.sum(factors_of(n))
    cond do
      aliquot == n -> {:ok, :perfect}
      aliquot > n -> {:ok, :abundant}
      aliquot < n -> {:ok, :deficient}
    end
  end
  def classify(_), do: {:error, "Classification is only possible for natural numbers."}

  defp factors_of(n), do: Enum.filter(1..(div(n, 2)), &(rem(n, &1) == 0))
end
