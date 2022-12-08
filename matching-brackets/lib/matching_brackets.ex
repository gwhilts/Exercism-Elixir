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
  defp check_brackets(_, :error), do: false
  defp check_brackets([h | tail], queue) do
    new_q = cond do
      h == List.first(queue) -> List.delete_at(queue, 0)
      h in @openers -> [@pairs[h] | queue]
      h in @closers -> :error
      true -> queue
    end
    check_brackets(tail, new_q)
  end
end
