defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops, bottom <- bottoms, filter(top, bottom, options), do: {top, bottom}
  end

  defp filter(top, bottom, options) do
    no_clash?(top, bottom)
    && within_max_price?(top, bottom, options[:maximum_price])
  end

  defp no_clash?(top, bottom), do: top[:base_color] != bottom[:base_color]
  defp within_max_price?(top, bottom, max_price) do
    case max_price do
      nil -> top[:price] + bottom[:price] <= 100
      _ -> top[:price] + bottom[:price] <= max_price
    end
  end
end
