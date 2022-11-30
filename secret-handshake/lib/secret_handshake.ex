defmodule SecretHandshake do
  import Bitwise

  def commands(code) do
    Enum.reduce(0..4, [], fn bit, moves -> add_move(code &&& 2 ** bit, moves) end)
    |> Enum.reverse()
  end

  def add_move(bit, moves) do
    case bit do
      1 -> ["wink"]
      2 -> ["double blink" | moves]
      4 -> ["close your eyes" | moves]
      8 -> ["jump" | moves]
      16 -> Enum.reverse(moves)
      _ -> moves
    end
  end
end
