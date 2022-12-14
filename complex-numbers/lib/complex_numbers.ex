defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real, _}) do
    real
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, inum}) do
    inum
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  (a + i * b) * (c + i * d) = (a * c - b * d) + (b * c + a * d) * i
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({a, b}, {c, d}) do
    {(a * c - b * d) , (b * c + a * d)}
  end
  def mul(n1, n2), do: mul(complex(n1), complex(n2))

  @doc """
  Add two complex numbers, or a real and a complex number
  (a + i * b) + (c + i * d) = (a + c) + (b + d) * i
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({a, b}, {c, d}) do
    {(a + c), (b + d)}
  end
  def add(n1, n2), do: add(complex(n1), complex(n2))

  @doc """
  Subtract two complex numbers, or a real and a complex number
  (a + i * b) - (c + i * d) = (a - c) + (b - d) * i
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub({a, b}, {c, d}) do
    {(a - c), (b - d)}
  end
  def sub(n1, n2), do: sub(complex(n1), complex(n2))

  @doc """
  Divide two complex numbers, or a real and a complex number
  (a + i * b) / (c + i * d) = (a * c + b * d)/(c^2 + d^2) + (b * c - a * d)/(c^2 + d^2) * i
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div({a, b}, {c, d}) do
    {(a * c + b * d)/(c**2 + d**2), (b * c - a * d)/(c**2 + d**2)}
  end
  def div(n1, n2), do: ComplexNumbers.div(complex(n1), complex(n2))

  @doc """
  Absolute value of a complex number
  |a + b * i| = sqrt(a^2 + b^2)
  """
  @spec abs(a :: complex) :: float
  def abs({a, b}) do
    :math.sqrt(a**2 + b**2)
  end

  @doc """
  Conjugate of a complex number
  a + b * i :: a - b * i
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}) do
    {a, -b}
  end

  @doc """
  Exponential of a complex number
  e^(a + i * b) = e^a * e^(i * b), the last term of which is given by Euler's formula e^(i * b) = cos(b) + i * sin(b).
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    mul({:math.exp(a), 0}, {:math.cos(b), :math.sin(b)})
  end

  # Private

  defp complex({a, b}), do: {a, b}
  defp complex(n), do: {n, 0}
end
