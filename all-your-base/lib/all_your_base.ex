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
  def convert(_digits, input_base, _output_base) when (input_base < 2) , do: {:error, "output base must be >= 2"}
  def convert(_digits, _input_base, output_base) when (output_base < 2) , do: {:error, "output base must be >= 2"}
  def convert(digits, input_base, output_base) do
    to_decimal(digits, input_base)
    |> digit_list()
    |> then(&{:ok, &1})
  end

  def to_decimal(digits, base) do
    {_, dec} =
      Enum.reverse(digits)
      |> Enum.reduce({0, 0}, fn n, {index, sum} -> { index + 1, sum + digit_to_dec(n, index, base)} end)
    dec
  end

  def digit_to_dec(0, _, _), do: 0
  def digit_to_dec(n, index, base) do
    n * (base ** index)
  end

  def digit_list(num) do
    Integer.to_charlist(num) |> Enum.map( &( String.to_integer <<&1>> ) )
  end

end
