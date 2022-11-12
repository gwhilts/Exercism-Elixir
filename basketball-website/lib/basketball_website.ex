defmodule BasketballWebsite do
  # Don't use Map or Kernel functions
  @spec extract_from_path(map(), String.t()) :: any
  def extract_from_path(data, path) do
    Enum.reduce(String.split(path, "."), data, fn(key, acc) -> acc[key] end)
  end

  # Use Kernel.get_in/2
  @spec get_in_path(map(), String.t()) :: any
  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
