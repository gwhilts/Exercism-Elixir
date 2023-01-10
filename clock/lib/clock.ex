defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    ~T[00:00:00]
    |> Time.add(hour, :hour)
    |> Time.add(minute, :minute)
    |> to_clock()
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(clock, minute) do
    to_time(clock)
    |> Time.add(minute, :minute)
    |> to_clock()
  end

  defp to_time(%Clock{hour: h, minute: m}), do: Time.from_erl!({h, m, 0})

  defp to_clock(t), do: %Clock{hour: t.hour, minute: t.minute}

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: h, minute: m}) do
      "#{padded h }:#{padded m }"
    end

    defp padded(int), do: Integer.to_string(int) |> String.pad_leading(2, "0")
  end
end
