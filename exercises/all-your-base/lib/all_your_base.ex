defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  # Instructions say "Try to implement the conversion yourself.
  # Do not use something else to perform the conversion for you."
  # So I assume this means avoid using something like
  # `List.to_integer(charlist, base)` and to implement the base
  # conversion algorithm myself

  # Given the number and complexity of the rules, it seemed cleaner to use
  # a cond, rather than muptiple fn defs with guards
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      output_base < 2 -> {:error, "output base must be >= 2"}
      input_base < 2 -> {:error, "input base must be >= 2"}
      Enum.any?  digits, &( &1 < 0) -> {:error, "all digits must be >= 0 and < input base"}
      Enum.any?  digits, &( &1 >= input_base) -> {:error, "all digits must be >= 0 and < input base"}
      true -> {:ok, safe_convert(digits, input_base, output_base)}
    end
  end

  def safe_convert(digits, input_base, output_base) do
    digits
    |> add_indexes() # feels like there should be something like List.each_with_index out there somewhere, but I couldn't find it
    |> to_decimal(input_base)
    |> to_digits(output_base)
  end

  # add indexes to this of digits:
  # [1, 0, 1] -> [{1, 2}, {0, 1}, {1, 0}]
  defp add_indexes(digits), do: Enum.zip(digits, (length(digits) - 1)..0)

  # transform the indexed list of digits from input base to decimal:
  # [{1, 2}, {0, 1}, {1, 0}], 2 -> (1 * 2^2) + (0 * 2^1) + (1 * 2^0) -> 9
  defp to_decimal(indexed_list, base), do: Enum.reduce(indexed_list, 0, fn({digit, index}, sum) -> sum + digit * (base**index) end)

  # transform a decimal number to a list of digits in the output base:
  # 9, 2 -> [1, 0, 1]
  defp to_digits(num, base, digits \\ [])
  defp to_digits(0, _base, digits), do: if Enum.empty?(digits), do: [0], else: digits
  defp to_digits(num, base, digits), do: to_digits(div(num, base), base, [rem(num, base) | digits])
end
