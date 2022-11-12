defmodule KitchenCalculator do

  def get_volume({_unit, volume}) do
    volume
  end

  def to_milliliter({unit, volume}) do
    {:milliliter, volume * ml_ratio()[unit]}
  end

  def from_milliliter({:milliliter, volume}, :milliliter), do: {:milliliter, volume}
  def from_milliliter({:milliliter, volume}, unit) do
    {unit, volume / ml_ratio()[unit]}
  end

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair)
    |> from_milliliter(unit)
  end

  defp ml_ratio do
    [ milliliter: 1,
      cup: 240,
      fluid_ounce: 30,
      teaspoon: 5,
      tablespoon: 15
    ]
  end
end
