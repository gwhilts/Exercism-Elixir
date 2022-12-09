defmodule Bowling do

  ## First pass. Sloppy. All tests passing, but it could use some tidying/refactoring

  @typedoc """
    A map representing a game of bowling, containing the current
    frame, the ball to be rolled, and a map of previously
    rolled frames:

      %{frame: 3, ball: 2, %{1 => [7, 2], 2 => [10], 3 => [8]}}

    In the example above, we're half way through the third frame
    of the game.
  """
  @type game :: %{
    frame: pos_integer(),
    ball: pos_integer(),
    frames: map()
  }

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: game
  def start do
    %{ball: 1, frame: 1, frames: %{}}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """
  @spec roll(game, pos_integer) :: {:ok, game} | {:error, String.t()}
  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(g, roll) do
    unless complete?(g.frames) do
      new_g = case {roll, g.ball} do
        {10, 1} -> %{ball: 1, frame: g.frame + 1, frames: Map.put(g.frames, g.frame, [roll])}
        {roll, 1} -> %{ball: 2, frame: g.frame, frames: Map.put(g.frames, g.frame, [roll])}
        {roll, 2} -> %{ball: 1, frame: g.frame + 1, frames: Map.update!(g.frames, g.frame, &(Enum.concat(&1, [roll])))}
      end
      if valid_frame?(Map.get(new_g.frames, g.frame)), do: {:ok, new_g}, else: {:error, "Pin count exceeds pins on the lane"}
    else
      {:error, "Cannot roll after game is over"}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """
  @spec score(game) :: {:ok, pos_integer} | {:error, String.t()}
  def score(g) do
    if complete?(g.frames) do
      {:ok, Enum.reduce(1..10, 0, fn f_num, sum -> sum + frame_score(g.frames, f_num) end)}
    else
      {:error, "Score cannot be taken until the end of the game"}
    end
  end

  # private

  defp complete?(frames) do
    tenth = Map.get(frames, 10, [])
    cond do
      Enum.count(frames) < 10 -> false
      Enum.sum(tenth) == 10 -> valid_bonus?(frames)
      Enum.count(tenth) == 1 -> false
      Enum.count(frames) == 10 -> true
    end
  end

  defp frame_score(frames, f_num) do
    f = Map.get(frames, f_num)
    cond do
      f == [10] -> 10 + next_two(f_num + 1, frames)
      Enum.sum(f) == 10 -> 10 + next_ball(f_num + 1, frames)
      true -> Enum.sum(f)
    end
  end

  defp next_ball(f_num, frames), do: Map.get(frames, f_num) |> List.first()

  defp next_two(f_num, frames) do
    case Map.get(frames, f_num) do
      [10] -> 10 + next_ball(f_num + 1, frames)
      [b1, b2] -> b1 + b2
    end
  end

  defp valid_bonus?(frames) do
    case {Map.get(frames, 10), Map.get(frames, 11, []), Map.get(frames, 12, [])} do
      {[10], [10], [_b1]} -> true
      {[10], [_b1, _b2], []} -> true
      {[_b1, _b2], [_b3], []} -> true
      _ -> false
    end
  end

  defp valid_frame?(frame), do: Enum.sum(frame) <= 10

end
