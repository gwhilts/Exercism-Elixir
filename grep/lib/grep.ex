defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    {inverse?, nocase?, whole_line?, only_file_names?, line_nums?} = parse_flags(flags)
    file_names? = Enum.count(files) > 1
    regex = build_regex(pattern, nocase?, whole_line?)

    files
    |> Enum.map(&parse_file/1)
    |> filter_lines(regex, inverse?)
    |> to_strings(only_file_names?, file_names?, line_nums?)
    |> List.flatten()
    |> Enum.join("\n")
    |> trailing_nl()
  end

  defp build_regex(pattern, nocase?, whole_line?) do
    case {nocase?, whole_line?} do
      {true, true} -> ~r/^#{pattern}$/i
      {true, false} -> ~r/#{pattern}/i
      {false, true} -> ~r/^#{pattern}$/
      {false, false} -> ~r/#{pattern}/
    end
  end

  defp cond_print(data, print?), do: if(print?, do: "#{data}:", else: "")

  defp filter_lines(p_files, regex, false), do: Enum.map(p_files, fn f -> %{f | lines: Enum.filter(f.lines, &Regex.match?(regex, elem(&1, 0)))} end)
  defp filter_lines(p_files, regex, true), do: Enum.map(p_files, fn f -> %{f | lines: Enum.reject(f.lines, &(Regex.match?(regex, elem(&1, 0)) or elem(&1, 0) == ""))} end)

  defp parse_file(file_name) do
    lines =
      File.read!(file_name)
      |> String.split("\n")
      |> Enum.with_index()

    %{name: file_name, lines: lines}
  end

  defp parse_flags(flags), do: {"-v" in flags, "-i" in flags, "-x" in flags, "-l" in flags, "-n" in flags}

  defp print_lines(f, file_names?, line_nums?), do: Enum.map(f.lines, fn {txt, ln} -> "#{cond_print(f.name, file_names?)}#{cond_print(ln + 1, line_nums?)}" <> txt end)

  defp to_strings(filtered_files, false, file_names?, line_nums?), do: Enum.map(filtered_files, &print_lines(&1, file_names?, line_nums?))
  defp to_strings(filtered_files, true, _, _), do: Enum.filter(filtered_files, fn f -> Enum.count(f.lines) > 0 end) |> Enum.map(& &1.name)

  defp trailing_nl(str), do: if(str == "" or String.ends_with?(str, "\n"), do: str, else: str <> "\n")
end
