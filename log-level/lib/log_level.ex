defmodule LogLevel do

  def to_label(level, legacy?) do
    # case {level, legacy?} do
    #   {0, false} -> :trace
    #   {1, _} -> :debug
    #   {2, _} -> :info
    #   {3, _} -> :warning
    #   {4, _} -> :error
    #   {5, false} -> :fatal
    #   {_, _} -> :unknown
    # end
    cond do
      (level == 0) && !legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      (level == 5) && !legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      !Enum.member?(1..4, level) && legacy? -> :dev1
      Enum.member?(0..3, level) -> false
      Enum.member?(4..5, level) -> :ops
      true -> :dev2
    end
  end
end
