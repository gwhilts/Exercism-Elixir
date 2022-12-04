defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  r₁ + r₂ = a₁/b₁ + a₂/b₂ = (a₁ * b₂ + a₂ * b₁) / (b₁ * b₂).
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    {a1 * b2 + a2 * b1, b1 * b2 } |> reduce
  end

  @doc """
  Subtract two rational numbers
  r₁ - r₂ = a₁/b₁ - a₂/b₂ = (a₁ * b₂ - a₂ * b₁) / (b₁ * b₂)
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    {a1 * b2 - a2 * b1 , b1 * b2} |> reduce
  end

  @doc """
  Multiply two rational numbers
  r₁ * r₂ = (a₁ * a₂) / (b₁ * b₂)
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    {(a1 * a2) , (b1 * b2)} |> reduce
  end

  @doc """
  Divide two rational numbers
  r₁ / r₂ = (a₁ * b₂) / (a₂ * b₁)
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    {a1 * b2 , a2 * b1} |> reduce
  end

  @doc """
  Absolute value of a rational number
  |a/b| = |a|/|b|
  """
  @spec abs(a :: rational) :: rational
  def abs({a1, b1}) do
    {Kernel.abs(a1), Kernel.abs(b1)} |> reduce
  end

  @doc """
  Exponentiation of a rational number by an integer
  (n < 0) -> r^n = (b^m)/(a^m), where m = |n|
  (n >= 0) -> r^n = (a^n)/(b^n)
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0 do
    m = Kernel.abs(n)
    {(b**m), (a**m)} |> reduce
  end

  def pow_rational({a, b}, n) do
    {(a**n), (b**n)} |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    x ** (a/b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({num, denom}) do
    gcd = Integer.gcd(num, denom)
    {div(num, gcd), div(denom, gcd)}
    |> fix_neg
  end

  defp fix_neg({num, denom}) when denom < 0, do: {num * -1, denom * -1}
  defp fix_neg(rational), do: rational
end
