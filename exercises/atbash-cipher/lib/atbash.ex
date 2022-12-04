defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  # First pass: seems a little long and drawn out, but it works
  # Will look for a more compact solution in the next iteration.

  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.to_charlist
    |> Enum.filter(&(&1 in ?a..?z or &1 in ?0..?9))
    |> Enum.map(&encode_char/1)
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.to_charlist()
    |> Enum.filter(&(&1 in ?a..?z or &1 in ?0..?9))
    |> Enum.map(&decode_char/1)
    |> Enum.join("")
  end

  defp encode_char(c), do: if c in ?a..?z, do: ?z - (c - ?a), else: c
  defp decode_char(c), do: if c in ?a..?z, do: <<?a + (?z - c)>>, else: <<c>>

end
