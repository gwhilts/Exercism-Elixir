defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(string) do
    num = String.replace(string, " ", "")
    String.length(num) > 1
    and !(Regex.match?(~r/[^\d]/, num))
    and rem(checksum(num), 10) == 0
  end

  # Private

  defp checksum(digits) do
    String.codepoints(digits)
    |> Enum.reverse()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {n, i}, sum -> if rem(i, 2) == 0, do: sum + n, else: sum + dbl_dig(n) end)
  end

  defp dbl_dig(n), do: if n * 2 > 9, do: (n * 2) - 9, else: (n * 2)
end
