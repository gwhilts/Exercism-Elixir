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
    |> Enum.map(&process/1)
    |> Enum.join()
    |> wrap_list()
  end



  defp process(t) do
    cond do
      String.match?(t, ~R/^#{1,6}[^#]/) -> parse_header_md_level(t) |> enclose_with_header_tag()
      String.starts_with?(t, "*") -> parse_list_md_level(t)
      true -> enclose_with_paragraph_tag(String.split(t))
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    t
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp wrap_list(l), do: String.replace(l, ~r|(<li>.*</li>)|, "<ul>\\1</ul>")

# Refactoring notes:

# Round one:
# - replace nested fun calls with pipelines
# - replace nested if/else with cond
# - other minor tidying up of unneeded anon functions and binary concat ops

# Round two:
# - replace messy patch/1 with wrap_list/1
#   - change name to reflect purpose
#   - replace all the weird reversing/replacing/reversing with a simple regex

end
