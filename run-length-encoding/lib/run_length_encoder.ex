defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints
    |> Enum.chunk_by( &(&1) )
    |> Enum.map( &compact_codepoints/1 )
    |> Enum.join
  end

  @spec decode(String.t()) :: String.t()
  def decode(string), do: Regex.scan(~r{(\d*)(.)}, string) |> Enum.reduce("", &expand_codepoints/2 )


  defp compact_codepoints(list) do
    case {length(list), hd(list)} do
      {1, cp} -> cp
      {n, cp} -> Integer.to_string(n) <> cp
    end
  end

  defp expand_codepoints([_match, count, cp], out) do
    case count do
      "" -> out <> cp
      n -> out <> String.duplicate(cp, String.to_integer(n))
    end
  end
end
