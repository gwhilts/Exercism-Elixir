defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> input |> calculator.() end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _error} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    trap = Process.flag(:trap_exit, true)
    result = Enum.map(inputs, &(start_reliability_check(calculator, &1)))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    Process.flag(:trap_exit, trap)
    result
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, fn(i) -> Task.async(fn() -> calculator.(i) end) end)
    |> Enum.map(&(Task.await(&1, 100)))
  end
end
