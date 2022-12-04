defmodule School do
  @type school :: [] | [{pos_integer(), String.t()}]

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new(), do: []

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    unless name in roster(school) do
      {:ok, [{grade, name} | school]}
    else
      {:error, school}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    Enum.reduce(school,[], fn {g, n}, students -> if g == grade, do: [n | students], else: students end)
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school), do: Enum.sort(school) |> Enum.map(fn({_grade, name}) -> name end)
end
