defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @spec encode(charlist()) :: bitstring
  def encode(dna), do: encode(dna, <<0::0>>)
  defp encode([], coded_dna), do: coded_dna
  defp encode([h | tail], coded_dna), do: encode(tail, <<coded_dna::bitstring, encode_nucleotide(h)::4>>)

  @spec decode(bitstring) :: [32 | 65 | 67 | 71 | 84]
  def decode(dna), do: decode(dna, '')
  defp decode(<<0::0>>, decoded_dna), do: decoded_dna
  defp decode(<<h::4, tail::bitstring>>, decoded_dna) do
    decode(tail, decoded_dna ++ [decode_nucleotide(h)])
  end

end
