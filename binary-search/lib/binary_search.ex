defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key), do: search(numbers, key, {0, tuple_size(numbers) - 1})
  defp search(numbers, key, {index, index}), do: if elem(numbers, index) == key, do: {:ok, index}, else: :not_found
  defp search(numbers, key, {low, high}) do
    index = (low + div(high - low, 2))
    cond do
      high < 0 -> :not_found
      elem(numbers, index) == key -> {:ok, index}
      elem(numbers, index) < key -> search(numbers, key, {index + 1, high})
      elem(numbers, index) > key -> search(numbers, key, {low, index - 1})
    end
  end
end
