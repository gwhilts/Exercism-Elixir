defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(input_string) do
    input_string
    |> String.upcase()
    |> String.replace(~r/[_\']/, "")
    |> String.split(~r/\W/)
    |> Enum.filter(&(Regex.match? ~r/[A-Z]/, &1))
    |> Enum.reduce("", fn(word, out) -> out <> String.first(word) end)
  end
end
