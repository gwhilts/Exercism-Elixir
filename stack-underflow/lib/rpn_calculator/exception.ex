defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(context) do
      case context do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> context}
      end
    end
  end

  @spec divide([number, ...]) :: integer
  def divide(list) when length(list) < 2, do: raise StackUnderflowError, "when dividing"
  def divide([divisor, _dividend]) when 0 == divisor, do: raise DivisionByZeroError
  def divide([divisor, dividend]), do: div(dividend, divisor)

end
