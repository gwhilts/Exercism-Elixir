defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_ | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(l), do: _reverse(l, [])
  defp _reverse([], rev_list), do: rev_list
  defp _reverse([h | tail], rev_list), do: _reverse(tail, [h | rev_list])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: _map(reverse(l), f, [])
  defp _map([], _f, new_list), do: new_list
  defp _map([h | tail], f, new_list), do: _map(tail, f, [f.(h) | new_list])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: _filter(reverse(l), f, [])
  defp _filter([], _f, new_list), do: new_list
  defp _filter([h | tail], f, new_list) do
    if f.(h), do: _filter(tail, f, [h | new_list]), else:  _filter(tail, f, new_list)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc
  def foldl([h | tail], acc, f), do: foldl(tail, f.(h, acc),f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: foldl(reverse(l), acc, f)

  @spec append(list, list) :: list
  def append(a, b) do
    foldl(b, reverse(a), fn e, acc -> [e| acc] end)
    |> reverse
  end

  @spec concat([[any]]) :: [any]
  def concat(ll), do: foldr(ll, [], &append/2)
end
