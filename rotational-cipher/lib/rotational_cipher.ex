defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn(char) -> shift_char(char, shift) end)
    |> List.to_string()
  end

  defp shift_char(char, rot) when char in ?a..?z, do: if char + rot > ?z, do: char + rot - 26, else: char + rot
  defp shift_char(char, rot) when char in ?A..?Z, do: if char + rot > ?Z, do: char + rot - 26, else: char + rot
  defp shift_char(char, _), do: char
end
