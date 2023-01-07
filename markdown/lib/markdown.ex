defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&wrap_line/1)
    |> add_emphasis()
    |> wrap_lists()
  end

  defp add_emphasis(text) do
    text
    |> String.replace(~r/__(.+)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.+)_/, "<em>\\1</em>")
  end

  defp wrap_line("#" <> line), do: wrap_header(line, 1)
  defp wrap_line("* " <> line), do: wrap_list_item(line)
  defp wrap_line(line), do: "<p>#{line}</p>"

  defp wrap_header(" " <> line, level), do: "<h#{level}>#{line}</h#{level}>"
  defp wrap_header("#" <> line, level) when level < 6, do: wrap_header(line, level + 1)
  defp wrap_header("#" <> line, _), do: wrap_paragraph("#######" <> line)

  defp wrap_lists(lines), do: String.replace(lines, ~r|(<li>.*</li>)|, "<ul>\\1</ul>")

  defp wrap_list_item(line), do: "<li>#{line}</li>"

  defp wrap_paragraph(line), do: "<p>#{line}</p>"
end

# Refactoring notes:

# Round one:
# - replace nested fun calls with pipelines
# - replace nested if/else with cond
# - other minor tidying up of unneeded anon functions and binary concat ops

# Round two:
# - replace messy patch/1 with wrap_list/1
#   - change name to reflect purpose
#   - replace all the weird reversing/replacing/reversing with a simple regex

# Round three
# - complete rewrite
#   - smarter function names
#   - cleaner impl using pattern matching & regex
# - Note:
#     This replicates the original behavior and passes all the test
#     but there are numerous cases of legimate markdown that would
#     fail to be correctly transformed (e.g. multiple lists, snake-cased
#     text, etc.)
