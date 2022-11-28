defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    case Enum.sort([a, b, c]) do
      [leg1, _, _]      when leg1 <= 0          -> {:error, "all side lengths must be positive"}
      [leg1, leg2, hyp] when leg1 + leg2 <= hyp -> {:error, "side lengths violate triangle inequality"}
      [leg1, leg1, leg1] -> {:ok, :equilateral}
      [leg1, leg1, _]    -> {:ok, :isosceles}
      [_, leg2, leg2]    -> {:ok, :isosceles}
      _                  -> {:ok, :scalene}
    end
  end
end
