defmodule Say do
  @num_words %{
    0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five",
    6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven",
    12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen",
    17 => "seventeen", 18 => "eightteen", 19 => "nineteen", 20 => "twenty", 30 => "thirty",
    40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number in 0..999_999_999_999, do: {:ok, build(number)}
  def in_english(_), do: {:error, "number is out of range"}

  defp build(num) do
    cond do
      num < 21 -> Map.get(@num_words, num)
      num < 100 -> tens(num)
      num < 1_000 -> big_uns(num, 100, " hundred")
      num < 1_000_000 -> big_uns(num, 1_000, " thousand")
      num < 1_000_000_000 -> big_uns(num, 1_000_000, " million")
      num < 1_000_000_000_000 -> big_uns(num, 1_000_000_000, " billion")
    end
  end

  defp tens(num) do
    case {div(num, 10), rem(num, 10)} do
      {digit, 0} -> Map.get(@num_words, digit * 10)
      {digit, rest} -> Map.get(@num_words, digit * 10) <> "-" <> build(rest)
    end
  end

  defp big_uns(num, factor, word) do
    case {div(num, factor), rem(num, factor)} do
      {digits, 0} -> build(digits) <> word
      {digits, rest} -> build(digits) <> word  <> " " <> build(rest)
    end
  end
end
