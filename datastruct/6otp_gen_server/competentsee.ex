"""
In your editor, implement and test a gen_server for a restaurant reservation system. It should:

Add reservations with a date, time, and party size.

Cancel specific reservations.

List reservations for a specific date or time period.
"""

defmodule ReservationServer do
  use GenServer

  # --- client api ---

  # starts the genserver
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # add a reservation
  def add_reservation(date, time, party_size) do
    GenServer.cast(__MODULE__, {:add, %{date: date, time: time, party_size: party_size}})
  end

  # cancel a reservation
  def cancel_reservation(date, time) do
    GenServer.cast(__MODULE__, {:cancel, date, time})
  end

  # list reservations for a date or time range
  def list_reservations(filter \\ :all) do
    GenServer.call(__MODULE__, {:list, filter})
  end

  # --- server callbacks ---

  # initialize with an empty map
  def init(state) do
    {:ok, state}
  end

  # add a reservation
  def handle_cast({:add, reservation}, state) do
    new_state = Map.update(state, reservation.date, [reservation], fn list ->
      [reservation | list]
    end)
    {:noreply, new_state}
  end

  # cancel a reservation
  def handle_cast({:cancel, date, time}, state) do
    new_state =
      case Map.get(state, date) do
        nil -> state
        reservations ->
          updated = Enum.reject(reservations, fn r -> r.time == time end)
          Map.put(state, date, updated)
      end
    {:noreply, new_state}
  end

  # list reservations
  def handle_call({:list, :all}, _from, state), do: {:reply, state, state}

  def handle_call({:list, date}, _from, state) do
    {:reply, Map.get(state, date, []), state}
  end
end
