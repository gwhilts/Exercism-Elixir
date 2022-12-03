defmodule Garden do
  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @plants %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  # @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    for n <- student_names, into: %{}, do: {n, get_plants(student_index(Enum.sort(student_names), n), String.split(info_string))}
  end

  defp get_plants(nil, _), do: {}
  defp get_plants(index, [row1, row2]) do
    to_tup(String.slice(row1, (index * 2)..(index * 2 +1)) <> String.slice(row2, (index * 2)..(index * 2 +1)))
  end

  defp to_tup(string) do
    String.codepoints(string)
    |> Enum.map(&(@plants[&1]))
    |> List.to_tuple()
  end

  defp student_index(list, name), do: Enum.find_index(list, &(&1 == name))
end
