defmodule IsbnVerifier do
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    digits = parse_digits(isbn) |> x_to_10(isbn)
    valid?(isbn) and rem(checksum(digits), 11) == 0
  end

  defp checksum(digits) do
    {checksum, _} = Enum.reduce(digits, {0, 1}, fn(d, {sum, index}) -> {sum + String.to_integer(d) * index, index + 1} end)
    checksum
  end

  defp parse_digits(isbn) do
    Regex.scan(~r/(\d)/, isbn)
    |> Enum.reduce([], fn([_, match], digits) -> [match | digits] end)
  end

  defp valid?(isbn), do: String.replace(isbn, "-", "") |> String.match?(~r/^\d{9}[\d|X]?$/)

  defp x_to_10(digits, isbn) do
    case String.last(isbn) do
      "X" -> ["10" | digits]
      _ -> digits
    end
  end
end
