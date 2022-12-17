defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(msg) do
    msg
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
    |> pad()
    |> to_norm_grid()
    |> to_enc_grid()
    |> to_str()
  end

  # Private

  defp demensions_for(str) do
    r = round(:math.sqrt(String.length(str)))
    c = ceil(String.length(str) / r)
    {r, c}
  end

  defp pad(str) do
    {r, c} = demensions_for(str)
    diff = r * c - String.length(str)
    str <> String.duplicate(" ", diff)
  end

  defp to_enc_grid(norm) do
    last_row = Enum.count(norm) - 1
    last_col = Enum.count(Enum.at(norm, 0)) - 1

    for(c <- 0..last_col, r <- 0..last_row, do: Enum.at(Enum.at(norm, r), c))
    |> Enum.chunk_every(last_row + 1)
  end

  defp to_norm_grid(str) do
    {_r, c} = demensions_for(str)
    String.codepoints(str) |> Enum.chunk_every(c)
  end

  defp to_str(grid) do
    Enum.map(grid, &Enum.join/1)
    |> Enum.join(" ")
  end
end
