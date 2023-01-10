defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key: E(x) = (ai + b) mod m
  """
  @spec encode(key :: key(), message :: String.t()) :: {:error, String.t()} | {:ok, String.t()}
  def encode(%{a: a, b: b}, msg), do: coprime_error(a, 26) || {:ok, _encode(a, b, msg)}

  @doc """
  Decode an encrypted message using a key: D(y) = (a^-1)(y - b) mod m where (a^-1) is the MMI of a, aka a_
  """
  @spec decode(key :: key(), message :: String.t()) :: {:error, String.t()} | {:ok, String.t()}
  def decode(%{a: a, b: b}, msg), do: coprime_error(a, 26) || {:ok, _decode(mmi(a), b, msg)}

# Private
  defp coprime_error(a, m), do: if Integer.gcd(a, m) == 1, do: nil, else: {:error, "a and m must be coprime."}

  defp _decode(a_, b, msg) do
    msg
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist()
    |> Enum.map_join(& decode_char(&1, a_, b))
  end

  defp decode_char(c, _, _) when c < ?a, do: <<c>>
  defp decode_char(c, a_, b), do: << Integer.mod(a_ * ((c - ?a) - b), 26) + ?a >>

  defp _encode(a, b, msg) do
    msg
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist()
    |> Enum.map(& encode_char(&1, a, b))
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  defp encode_char(c, _, _) when c < ?a, do: <<c>>
  defp encode_char(c, a, b), do: << Integer.mod((a * (c - ?a) + b), 26) + ?a >>

  # Probably a smarter way to do this, but my maths suck
  defp mmi(a) do
    Enum.reduce_while 2..max(a, 26), 1, fn a_, _ ->
      case Integer.mod(a * a_, 26) do
        1 -> {:halt, a_}
        _ -> {:cont, 1}
      end
    end
  end
end
