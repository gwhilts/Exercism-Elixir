defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: %{next_frame: integer, frames: %{}}
  def start do
    %{ball: 1, frame: 1, frames: %{}}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  # @spec roll({{int, int}, %{}}, integer) :: {:ok, any} | {:error, String.t()}
  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(g, roll) do
    new_g = case {roll, g.ball} do
      {10, 1} -> %{ball: 1, frame: g.frame + 1, frames: Map.put(g.frames, g.frame, [roll])}
      {roll, 1} -> %{ball: 2, frame: g.frame, frames: Map.put(g.frames, g.frame, [roll])}
      {roll, 2} -> %{ball: 1, frame: g.frame + 1, frames: Map.update!(g.frames, g.frame, &(Enum.concat(&1, [roll])))}
    end
    if valid_frame?(Map.get(new_g.frames, g.frame)), do: {:ok, new_g}, else: {:error, "Pin count exceeds pins on the lane"}
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score([integer]) :: {:ok, integer} | {:error, String.t()}
  def score(g) do
    if complete?(g.frames) do
      {:ok, Enum.reduce(1..10, 0, fn f_num, sum -> sum + frame_score(g.frames, f_num) end)}
    else
      IO.inspect(g)
      {:error, "Score cannot be taken until the end of the game"}
    end
  end


  # TODO: You can't roll two strikes in one frame, dipshit
  def frame_score(frames, f_num) do
    f = Map.get(frames, f_num)
    cond do
      f == [10] -> 10 + next_two(f_num + 1, frames)
      Enum.sum(f) == 10 -> 10 + next_ball(f_num + 1, frames)
      true -> Enum.sum(f)
    end
  end

  def next_ball(f_num, frames) do
    Map.get(frames, f_num)
    |> List.first()
  end
  def next_two(f_num, frames) do
    case Map.get(frames, f_num) do
      [10] -> 10 + next_ball(f_num + 1, frames)
      [b1, b2] -> b1 + b2
    end
  end

  def valid_frame?(frame), do: Enum.sum(frame) <= 10

  # RESUME -> NOT WORKING, seems to be related to 2 bonus rolls (11th v 12th frame)
  def complete?(frames) do
    if Enum.count(frames) < 10 do
       false
    else
      IO.inspect(frames, label: "\nFrames: ")
      true
    end
    #   tenth = Map.get(frames, 10)
    #   cond do
    #     tenth == [10] -> length(Map.get(frames, 11, [])) == 2
    #     Enum.sum(tenth) == 10 -> length(Map.get(frames, 11, [])) == 1
    #     true -> true
    #   end
    # end
  end
end
