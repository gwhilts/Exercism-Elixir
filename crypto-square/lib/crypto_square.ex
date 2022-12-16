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
    |> to_norm_grid()
    |> to_enc_grid()
    |> Enum.map(fn(row) -> Enum.join(row) end)
    |> Enum.join(" ")
  end

  #spec to_norm_grid(String.t()) :: {[[String.t()]], {pos_integer, pos_integer}}
  defp to_norm_grid(str) do
    {_r, c} = demensions_for(str)
    String.codepoints(str) |> Enum.chunk_every(c)
  end

  #spec to_enc_grid([[binary]]) :: [[binary]]
  def to_enc_grid(norm) do
    last_row = (Enum.count(norm) - 1)
    last_col = (Enum.count(Enum.at(norm, 0)) - 1)
    (for c <- 0..last_col, r <- 0..last_row, do: Enum.at(Enum.at(norm, r, [" "]), c, " "))
    |> Enum.chunk_every(last_col + 1)
  end

  #spec demensions_for(binary) :: {integer, integer}
  # demensions_for("abcd") :: {2, 2}
  defp demensions_for(str) do
    r = trunc(:math.sqrt(String.length(str)))
    c = round(String.length(str) / r)
    {r, c}
  end
end
