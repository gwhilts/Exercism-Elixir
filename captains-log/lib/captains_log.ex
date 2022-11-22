defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random @planetary_classes
  end

  def random_ship_registry_number() do
    "NCC-" <> Integer.to_string(Enum.random(1000..9999))
  end

  def random_stardate() do
    41_000 + (:rand.uniform() * 1000)
  end

  def format_stardate(stardate) do
    # :erlang.float_to_binary(stardate, [{:decimals, 1}]) # I like this one better, but E doesn't
    :io_lib.format("~.1f", [stardate]) |> to_string
  end
end
