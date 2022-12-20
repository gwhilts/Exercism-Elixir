defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) do
    if valid?(number_string, size) do
      String.codepoints(number_string)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(size, 1, :discard)
      |> Enum.map(fn digits -> Enum.reduce(digits, 1, &*/2) end)
      |> Enum.max
    else
      raise ArgumentError
    end
  end

  # Private

  defp valid?(nstring, size) do
    cond do
      nstring == "" -> false
      String.length(nstring) < size -> false
      Regex.match? ~r/[^\d]/, nstring -> false
      size < 0 -> false
      true -> true
    end
  end
end
