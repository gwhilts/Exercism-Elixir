defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(char) do
    width = (char - 64) * 2 - 1
    top = rows_to(char, width)
    Enum.join(top) <> Enum.join(tl(Enum.reverse(top)))
  end

  defp row(?A), do: "A"
  defp row(char), do: <<char>> <> String.duplicate(" ", spaces(char)) <> <<char>>
  defp row(char, width) do
    core = row(char)
    pad = String.duplicate(" ", div((width - String.length(core)), 2))
    pad <> core <> pad <> "\n"
  end

  defp rows_to(char, width), do: for c <- ?A..(char), do: row(c, width)

  defp spaces(char), do: (char - 64) * 2 - 3
end
