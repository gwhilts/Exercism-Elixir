defmodule LinkedList do
  @opaque t :: tuple()

  # When implementing this in a
  # language with built-in linked
  # lists, implement your own abstract
  # data type.

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: Tuple.insert_at(list, 0, elem)

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: tuple_size(list)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list), do: count(list) == 0

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list), do: if empty?(list), do: {:error, :empty_list}, else: {:ok, elem(list, 0)}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list), do: if empty?(list), do: {:error, :empty_list}, else: {:ok, Tuple.delete_at(list, 0)}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list), do: if empty?(list), do: {:error, :empty_list}, else: {:ok, elem(list, 0), Tuple.delete_at(list, 0)}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    Enum.reverse(list)
    |> Enum.reduce({}, fn e, t -> Tuple.insert_at(t, 0, e) end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({}), do: []
  def to_list(t), do: for i <- 0..(count(t) - 1), do: elem(t, i)

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(t) do
    to_list(t)
    |> Enum.reverse()  # cheating?
    |> from_list()
  end
end
