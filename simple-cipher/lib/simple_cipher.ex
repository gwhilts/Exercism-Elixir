defmodule SimpleCipher do
  @spec encode(String.t(), String.t()) :: String.t()
  def encode(plaintext, key), do: zip(plaintext, key) |> Enum.map(&shift/1) |> Enum.join()

  @spec decode(String.t(), String.t()) :: String.t()
  def decode(ciphertext, key), do: zip(ciphertext, key) |> Enum.map(&unshift/1) |> Enum.join()

  @spec generate_key(pos_integer) :: String.t()
  def generate_key(length),
    do: for(_i <- 1..length, do: 96 + :rand.uniform(26)) |> List.to_string()

  # private

  # {?b, ?b} -> "c"
  defp shift({char, key_char}) do
    c = char + key_char - 97
    if c > ?z, do: <<c - 26>>, else: <<c>>
  end

  # {?b, ?b} -> "a"
  defp unshift({char, key_char}) do
    c = char - (key_char - 97)
    if c < ?a, do: <<c + 26>>, else: <<c>>
  end

  # "abcd", "xy" -> [{?a, ?x}, {?b, ?y}, {?c, ?x}, {?d, ?y}]
  # "xy", "abcd" -> [{?x, ?a}, {?y, ?b}]
  defp zip(text, key),
    do: Enum.zip(String.to_charlist(text), Stream.cycle(String.to_charlist(key)))
end
