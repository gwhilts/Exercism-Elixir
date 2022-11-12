defmodule BasketballWebsite do
  # Don't use Map or Kernel functions
  @spec extract_from_path(map(), String.t()) :: any
  def extract_from_path(data, path), do: extract_from_path(data, String.split(path, "."), "")
  defp extract_from_path(_data, [], val), do: val
  defp extract_from_path(data, [h | tail], _val), do: extract_from_path(data[h], tail, data[h])

  # Use Kernel.get_in/2
  @spec get_in_path(map(), String.t()) :: any
  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
