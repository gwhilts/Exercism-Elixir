defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.

  (I1: What about `Enum.reduce`? Is that off the table as well?
  Guess I'll use tail recursion to start. - gwh)

  (I2: Didn't now about the guards on for loops. Let's try that. - gwh)
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    for e <- list, fun.(e), do: e
  end


  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    for e <- list, !fun.(e), do: e
  end
end
