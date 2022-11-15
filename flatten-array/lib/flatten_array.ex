defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  # This seems too easy. Were we supposed to
  # rewrite the implentation of List.flatten/1
  # and/or Enum.filter/2 ???

  @spec flatten(list) :: list
  def flatten(list) do
    List.flatten(list)
    |> Enum.filter(&(&1))
  end
end
