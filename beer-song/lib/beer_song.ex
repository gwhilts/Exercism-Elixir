defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(n) do
    """
    #{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
    Take #{pronoun(n)} down and pass it around, #{bottles(n-1)} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    (for n <- Enum.to_list(range), do: BeerSong.verse(n)) |> Enum.join("\n")
  end

  defp bottles(n) do
    case n do
      0 -> "no more bottles"
      1 -> "1 bottle"
      _ -> "#{n} bottles"
    end
  end

  defp pronoun(n) do
    case n do
      1 -> "it"
      _ -> "one"
    end
  end
end
