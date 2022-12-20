defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(texts, &freqs_for/1, max_concurrency: workers)
    |> Enum.map(fn {:ok, map} -> map end)
    |> Enum.reduce(%{}, & Map.merge(&1, &2, fn _key, val1, val2 -> val1 + val2 end))
  end

  # Private

  defp freqs_for(str) do
    String.downcase(str)
    |> String.replace(~r/[^a-zà-ÿ]/, "")
    |> String.codepoints()
    |> Enum.frequencies()
  end
end
