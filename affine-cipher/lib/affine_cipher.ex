defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  # m = size of alphabet
  @m 26

  @doc """
  Encode an encrypted message using a key
  E(x) = (ai + b) mod m
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, msg), do: coprime_error(a, @m) || {:ok, _encode(a, b, msg)}

  @doc """
  Decode an encrypted message using a key
  D(y) = (a^-1)(y - b) mod m   ---  a^ = mmi(a)
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, msg), do: coprime_error(a, @m) || {:ok, _decode(mmi(a), b, msg)}

# Private

  defp coprime?(a, m), do: gcd(a, m) == 1

  defp coprime_error(a, m), do: if coprime?(a, m), do: nil, else: {:error, "a and m must be coprime."}

  defp _decode(a_, b, encrypted) do
    encrypted
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist()
    |> Enum.map(& decode_char(&1, a_, b))
    |> Enum.join()
  end

  defp decode_char(c, _, _) when c < ?a, do: <<c>>
  defp decode_char(c, a_, b), do: << Integer.mod(a_ * ((c - ?a) - b), @m) + ?a >>

  defp _encode(a, b, message) do
    message
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist()
    |> Enum.map(& encode_char(&1, a, b))
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  defp encode_char(c, _, _) when c < ?a, do: <<c>>
  defp encode_char(c, a, b), do: << Integer.mod((a * (c - ?a) + b), @m) + ?a >>

  defp gcd(x, 0), do: x
  defp gcd(x, y), do: gcd(y, rem(x,y))

  # Probably a smarter way to do this, but my maths suck
  defp mmi(a) do
    Enum.reduce_while(2..max(a, @m), 1, fn a_, _ ->
      case Integer.mod(a * a_, @m) do
        1 -> {:halt, a_}
        _ -> {:cont, 1}
      end
    end)
  end
end
