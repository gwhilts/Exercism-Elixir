defmodule Poker do

  ## Exercism:
  #
  # Second pass: Just a bit of tidying
  # Could still use some refactoring, or
  # may even a better algoritm.


  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    hmap = parse_hands(hands)
    (  straight_flushes(hmap)
    || fours_of_a_kind(hmap)
    || full_houses(hmap)
    || flushes(hmap)
    || straights(hmap)
    || maybe(threes_of_kind hmap)
    || maybe(two_pairs hmap)
    || maybe(pairs hmap)
    || hmap
    ) |> highest_score
  end

  defp highest_score(hmap) do
    hmap
    |> Enum.reduce(%{score: [], hands: []}, fn {key, parsed_hand}, winning ->
        pips = pip_counts(parsed_hand)
        cond do
          winning.score < score(pips) -> %{score: score(pips), hands: [key]}
          winning.score == score(pips) -> %{score: winning.score, hands: [key | winning.hands]}
          true -> winning
        end
      end)
    |> Map.get(:hands)
  end

  # Each returns hmap of hands that match or nil
  # Most follow pattern map |> filter |> maybe()
  # Straight and Straight flush are a bit wonkier

  defp flushes(hmap) do
    hmap
    |> Map.filter(fn {_key, parsed_hand} -> Enum.frequencies(suits(parsed_hand)) |> Map.values |> Enum.any?(& &1 == 5) end)
    |> maybe()
  end

  defp fours_of_a_kind(hmap) do
    hmap
    |> Map.filter(fn {_key, parsed_hand} -> Enum.frequencies(pip_counts(parsed_hand)) |> Map.values |> Enum.any?(& &1 == 4) end)
    |> maybe()
  end

  defp full_houses(hmap) do
    hmap
    |> Map.filter(fn {_key, parsed_hand} -> Enum.frequencies(pip_counts(parsed_hand)) |> Map.values() |> (&Enum.sort(&1) == [2, 3]).() end)
    |> maybe()
  end

  defp pairs(hmap) do
    Map.filter(hmap, fn {_key, parsed_hand} -> Enum.frequencies(pip_counts(parsed_hand)) |> Map.values |> Enum.any?(& &1 == 2) end)
  end

  defp straight_flushes(hmap), do: if flushes(hmap), do: flushes(hmap) |> straights()

  defp straights(hmap) do
    hmap
    |> Map.filter(fn {_key, parsed_hand} -> pip_counts(parsed_hand) |> has_straight?() end)
    |> Enum.into(%{}, fn {key, parsed_hand} -> if pip_counts(parsed_hand) == [14, 5, 4, 3, 2], do: {key, ace_low(parsed_hand)}, else: {key, parsed_hand} end)
    |> maybe()
  end

  defp threes_of_kind(hmap)  do
    Map.filter(hmap, fn {_key, parsed_hand} -> Enum.frequencies(pip_counts(parsed_hand)) |> Map.values |> Enum.any?(& &1 == 3) end)
  end

  defp two_pairs(hmap) do
    Map.filter(hmap, fn {_key, parsed_hand} -> Enum.frequencies(pip_counts(parsed_hand)) |> Map.values |> Enum.frequencies() |> Map.values |> Enum.any?(& &1 == 2) end)
  end

# Helper functions
  defp ace_low(parsed_hand), do: Enum.map(parsed_hand, fn {pips, suit} -> if pips == 14, do: {1, suit}, else: {pips, suit} end)

  defp pip_value(face) do
    face
    |> String.replace("A", "14")
    |> String.replace("K", "13")
    |> String.replace("Q", "12")
    |> String.replace("J", "11")
    |> String.to_integer()
  end

  defp has_straight?([14 | tail]), do: [13, 12, 11, 10] == tail or [5, 4, 3, 2] == tail
  defp has_straight?(pips), do: String.contains? "13-12-11-10-9-8-7-6-5-4-3-2", Enum.join(pips, "-")

  defp parse_hands(hands), do: for h <- hands, into: %{}, do: {h, Enum.map(h, &to_tuple/1)}

  defp pip_counts(parsed_hand), do: Enum.map(parsed_hand, fn {pips, _suit} -> pips end) |> Enum.sort(:desc)

  defp score(pips), do: Enum.frequencies(pips) |> Enum.sort(fn {_, v1}, {_, v2} -> v1 > v2 end) |> Enum.map(fn {k, _v} -> k end)

  defp suits(parsed_hand), do: Enum.map(parsed_hand, fn {_pips, suit} -> suit end)

  defp to_tuple(str) do
    [[_, face, suit]] = Regex.scan(~r/(.*)(.)$/, str)
    {pip_value(face), suit}
  end

  defp maybe(data), do: if Enum.empty?(data), do: nil, else: data
end
