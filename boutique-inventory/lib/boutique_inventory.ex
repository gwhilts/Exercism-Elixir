defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, &(&1[:price] <= &2[:price]))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &( &1[:price] == nil ))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &( %{ &1 | :name => String.replace(&1[:name], old_word, new_word) } ))
  end

  def increase_quantity(item, count) do
    %{item | quantity_by_size: increase_values(item[:quantity_by_size], count)}
  end

  defp increase_values(map, count) do
    Enum.reduce(map, %{}, fn({key, val}, acc) -> Map.put acc, key, val + count end)
  end

  def total_quantity(item) do
    Map.values(item[:quantity_by_size]) |> Enum.sum()
  end
end
