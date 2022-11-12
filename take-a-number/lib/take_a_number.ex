defmodule TakeANumber do
  def start() do
    spawn( fn -> get_number(0) end)
  end

  def get_number(num) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, num)
        get_number(num)
      {:take_a_number, sender_pid} ->
        send(sender_pid, num + 1)
        get_number(num + 1)
      :stop ->
        :ok
      _ ->
        get_number(num)
    end

  end
end
