"""
In your editor, implement the following scenario from the State Pattern topic:

Scenario:
Create a stateful function that toggles between two states: on and off. Test it by toggling multiple times.
"""
defmodule Toggle do
  @doc """
  Returns a toggle function that switches between :on and :off
  each time it is called.
  """
  def new() do
    state = :off

    fn ->
      state =
        case state do
          :off -> :on
          :on  -> :off
        end

      state
    end
  end
end
