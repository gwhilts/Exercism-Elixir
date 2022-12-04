defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &( &1[:price] == nil ))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &( %{ &1 | :name => String.replace(&1[:name], old_word, new_word) } ))
  end

  def increase_quantity(item, count) do
   %{item | quantity_by_size: Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)}
  end

# Elixir feedback said to "Use the Enum.reduce function in the total_quantity
# function to practice. It's the best fitting Enum function for this task."
# I like reduce, but my solution is much simpler and clearer.
  def total_quantity(item) do
    Map.values(item[:quantity_by_size]) |> Enum.sum()
  end
end
