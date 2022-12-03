defmodule PigLatin do
  # Match rules (could have combines some of these, but left separate for clarity)
  @default ~r/^([^aeiou]+)(.*)$/i # Starts w/ 1 or more cons
  @cons_y ~r/^([^aeiouy]+)(.*)$/i # Starts w/ cons followed by a y
  @qu ~r/^(qu)(.*)$/i             # Starts w/ qu
  @squ ~r/^([^aeiou]qu)(.*)$/i    # Starts w/ cons + qu
  @vowel ~r/^[aeiou]/i            # Starts w/ a vowel
  @xy_cons ~r/^[x|y][^aeiou]/i    # Starts w x or y followed by a cons (i.e. vowel sound start)


  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(w) do
    cond do
      vowel_start?(w) -> w <> "ay"
      r = Regex.run @qu, w -> transform r
      r = Regex.run @squ, w -> transform r
      r = Regex.run @cons_y, w -> transform r
      r = Regex.run @default, w -> transform r
    end
  end

  defp transform(parsed), do: Enum.at(parsed, 2) <> Enum.at(parsed, 1) <> "ay"
  defp vowel_start?(w), do: Regex.match?(@vowel, w) or Regex.match?(@xy_cons, w)
end
