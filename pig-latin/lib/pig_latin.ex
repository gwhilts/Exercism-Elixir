defmodule PigLatin do
  @qu ~r/^(qu)(.*)$/i
  @squ ~r/^([^aeiou]qu)(.*)$/i
  @vowel ~r/^[aeiou]/i
  @cons_y ~r/^([^aeiouy]+)(.*)$/i
  @default ~r/^([^aeiou]+)(.*)$/i
  @xy_cons ~r/^[x|y][^aeiou]/i

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&word/1)
    |> Enum.join(" ")
  end

  def word(w) do
    cond do
      Regex.match? @vowel, w -> w <> "ay"
      Regex.match? @xy_cons, w -> w <> "ay"
      r = Regex.run @qu, w -> transform r
      r = Regex.run @squ, w -> transform r
      r = Regex.run @cons_y, w -> transform r
      r = Regex.run @default, w -> transform r
    end
  end

  def transform(parsed) do
    {rest = Enum.at(parsed, 2), start = Enum.at(parsed, 1)}
    rest <> start <> "ay"
  end
end
