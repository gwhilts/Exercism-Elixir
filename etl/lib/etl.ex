defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce input, %{}, &( Map.merge &2, flip(&1) )
  end

  defp flip({score, letters}) do
    Enum.reduce letters, %{}, fn(tile, acc) -> Map.put(acc, String.downcase(tile), score) end
  end


end
