defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number), do: number == armstrong_sum_of(number)

  defp armstrong_sum_of(number) do
    digits = Integer.digits(number)
    List.foldl(digits, 0, fn(d, sum) -> d ** length(digits) + sum end)
  end
end
