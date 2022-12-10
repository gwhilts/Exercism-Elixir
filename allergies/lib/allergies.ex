defmodule Allergies do
  import Bitwise
  @allergies %{"eggs" => 1, "peanuts" => 2, "shellfish" => 4, "strawberries" => 8, "tomatoes" => 16, "chocolate" => 32, "pollen" => 64, "cats" => 128}

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    Enum.reduce(@allergies, [], fn {allergen, val}, lst -> if (flags &&& val) == val, do: [allergen | lst], else: lst end)
    |> Enum.reverse()
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item), do: (flags &&& Map.get(@allergies, item)) == Map.get(@allergies, item)
end
