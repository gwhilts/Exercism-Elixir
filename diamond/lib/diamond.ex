defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  # @spec build_shape(char) :: String.t()
  def build_shape(char) do
    center = row(char, 0)
    width = String.length(center)
    top = rows_to(char, width)
    Enum.join(top) <> center <> "\n" <> Enum.join(Enum.reverse(top))
  end

  defp row(?A, 0), do: "A"
  defp row(char, 0), do: <<char>> <> String.duplicate(" ", spaces(char)) <> <<char>>
  defp row(char, width) do
    core = row(char, 0)
    pad = String.duplicate(" ", div((width - String.length(core)), 2))
    pad <> core <> pad <> "\n"
  end

  defp rows_to(?A, _), do: [""]
  defp rows_to(char, width), do: for c <- ?A..(char - 1), do: row(c, width)

  defp spaces(char), do: (char - 64) * 2 - 3
end
