defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      shouting_question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp question?(input), do: String.trim(input) |> String.ends_with?("?")
  defp shouting?(input), do: (String.upcase(input) == input) && input =~ ~r/[A-ZА-Я]/
  defp shouting_question?(input), do: shouting?(input) && question?(input)
  defp silence?(input), do: "" == String.trim(input)

end
