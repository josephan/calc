defmodule Calc.CalculatorServer do
  use ExActor.GenServer

  defstart start_link, do: initial_state(%{display: "0", numbers: [], value: 0, current_operation: :noop})

  defcall get_display, state: state, do: reply(state.display)

  defcast number(num), state: state do
    new_numbers = state.numbers ++ [num]
    new_state(%{state | numbers: new_numbers, display: Enum.join(new_numbers)})
  end

  defcast add, state: state do
    update_state(state, :addition) |> new_state
  end

  defcast equals, state: state do
    update_state(state, :noop) |> new_state
  end

  defcast subtract, state: state do
    update_state(state, :subtraction) |> new_state
  end

  defcast multiply, state: state do
    update_state(state, :multiply) |> new_state
  end

  defcast divide, state: state do
    update_state(state, :divide) |> new_state
  end

  def update_state(state, new_operation) do
    entered_number = get_entered_number(state.numbers)
    new_value = get_new_value(state.value, entered_number, state.current_operation)
    new_display = "#{new_value}"
    %{state | numbers: [], display: new_display, value: new_value, current_operation: new_operation}
  end

  def get_entered_number(numbers) do
    {entered_number, _rest} = numbers |> Enum.join |> Integer.parse
    entered_number
  end

  def get_new_value(current_value, number, operation) do
    case operation do
      :noop     -> number
      :addition -> current_value + number
      :subtraction -> current_value - number
      :multiply -> current_value * number
      :divide -> current_value / number
    end
  end
end

