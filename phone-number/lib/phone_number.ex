defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> String.replace(~r/[-\.\(\)\+ ]/, "")
    |> validate
  end

  defp validate(data) do
    {country_code, num} = split_num(data)

    cond do
      msg = length_error?(country_code, num) -> {:error, msg}
      String.match?(num, ~r/[^0-9]/) -> {:error, "must contain digits only"}
      ac_zero?(num) -> {:error, "area code cannot start with zero"}
      ac_one?(num) -> {:error, "area code cannot start with one"}
      ex_zero?(num) -> {:error, "exchange code cannot start with zero"}
      ex_one?(num) -> {:error, "exchange code cannot start with one"}
      true -> {:ok, num}
    end
  end

  defp split_num(data) do
    if String.length(data) == 11 do
      <<c_code :: utf8, tail :: binary>> = data
      {<<c_code>>, tail}
    else
      {nil, data}
    end
  end

  defp length_error?(country_code, data) do
    case {country_code, String.length(data)} do
    {"1", 10} -> nil
    {nil, 10} -> nil
    {_, 10}   -> "11 digits must start with 1"
    _         -> "incorrect number of digits"
    end
  end

  defp ac_one?(num), do: String.match?(num, ~r/^1/)
  defp ac_zero?(num), do: String.match?(num, ~r/^0/)
  defp ex_one?(num), do: String.match?(num, ~r/^...1/)
  defp ex_zero?(num), do: String.match?(num, ~r/^...0/)
end
