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
    to_decimal(digits, input_base)
    |> digit_list(output_base)
  end

  # Transform the list of digits to decimal integer
  @spec to_decimal(list[integer()], integer()) :: integer()
  def to_decimal(digits, base) do
    {_, dec} =
      Enum.reverse(digits)
      |> Enum.reduce({0, 0}, fn n, {index, sum} -> { index + 1, sum + digit_to_dec(n, index, base)} end)
    dec
  end

  defp digit_to_dec(n, index, base) do
    n * (base ** index)
  end

  # Transform the list of integers in base 10 to a list of integers in output base
  # Note, values are still base 10ish, i.e. hex f is [15], not [0xf] or ["f"]
  @spec digit_list(integer, integer) :: list(integer)
  def digit_list(num, _base) do
    # Is there a more direct way to get from 123 to [1]
    Integer.to_charlist(num) |> Enum.map( &( String.to_integer <<&1>> ) )
  end

  # How many digits are in the num when converted to base?
  # should be able to do this with `1 + log(num, base)`, but
  # can't figure out how to do this in Elixir/Erlang.
  # There :math.log/1 .log10/1 and :math.log2/1, but ...
  def highest_power(num, base, index \\ 0) do
    IO.puts("#{base}, #{index} -> #{Integer.pow(index, base)} > #{num}")
    if (Integer.pow(index, base) > num) do
      index
    else
      highest_power(num, base, index + 1)
    end
  end

end
