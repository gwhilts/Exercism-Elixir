defmodule MatchingBrackets do
  @pairs %{"[" => "]", "{" => "}", "(" => ")"}
  @openers Map.keys(@pairs)
  @closers Map.values(@pairs)

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def  check_brackets(str), do: String.codepoints(str) |> check_brackets([])
  defp check_brackets([], []), do: true
  defp check_brackets([], _queue), do: false
  defp check_brackets([h | tail], queue) do
    good = List.first(queue)
    bad = List.delete(@closers, good)
    cond do
      h == good -> check_brackets(tail, List.delete_at(queue, 0))
      h in @openers -> check_brackets(tail, [@pairs[h] | queue])
      h in bad -> false
      true -> check_brackets(tail, queue)
    end
  end
end
