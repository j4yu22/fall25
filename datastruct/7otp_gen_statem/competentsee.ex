"""
In your editor, design and test a gen_statem for a door locking system. It should:

Have states: Locked, Unlocked, and Alarm.

Transition to Alarm if an incorrect code is entered three times.

Transition to Locked or Unlocked based on correct input.
"""

defmodule DoorLock do
  use GenStateMachine, callback_mode: :handle_event_function

  # start the state machine
  def start_link(_) do
    GenStateMachine.start_link(__MODULE__, :locked, name: __MODULE__)
  end

  # initialize state data
  def init(:locked) do
    {:ok, :locked, %{attempts: 0, code: "1234"}}
  end

  # handle events for the locked state
  def handle_event(:cast, {:enter_code, input}, :locked, data) do
    cond do
      input == data.code ->
        IO.puts("door unlocked")
        {:next_state, :unlocked, %{data | attempts: 0}}

      data.attempts + 1 >= 3 ->
        IO.puts("alarm triggered")
        {:next_state, :alarm, %{data | attempts: 0}}

      true ->
        IO.puts("incorrect code")
        {:keep_state, %{data | attempts: data.attempts + 1}}
    end
  end

  # handle events for the unlocked state
  def handle_event(:cast, :lock, :unlocked, data) do
    IO.puts("door locked")
    {:next_state, :locked, data}
  end

  # handle events for the alarm state
  def handle_event(:cast, :reset, :alarm, data) do
    IO.puts("alarm reset")
    {:next_state, :locked, %{data | attempts: 0}}
  end

  # catch-all
  def handle_event(_, _, state, data), do: {:keep_state, data}

  # public functions for testing
  def enter_code(code), do: GenStateMachine.cast(__MODULE__, {:enter_code, code})
  def lock, do: GenStateMachine.cast(__MODULE__, :lock)
  def reset, do: GenStateMachine.cast(__MODULE__, :reset)
end
