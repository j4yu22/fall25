"""
In your editor, write a stateful process to track the highest and lowest temperatures recorded during a day.
"""

defmodule TemperatureTracker do
  use GenServer

  """
  a simple process that tracks the highest and lowest temperatures

  functions:
    start_link/0 - starts the tracker with no temperatures recorded
    record_temp/1 - updates the highest and lowest temperatures
    get_temps/0 - returns the current highest and lowest values
  """

  # start the process
  def start_link do
    GenServer.start_link(__MODULE__, %{high: nil, low: nil}, name: __MODULE__)
  end


  # record a new temperature
  def record_temp(temp) do
    GenServer.cast(__MODULE__, {:record_temp, temp})
  end


  # get the current high and low temperatures
  def get_temps do
    GenServer.call(__MODULE__, :get_temps)
  end


  # server callbacks
  def init(state) do
    {:ok, state}
  end


  def handle_cast({:record_temp, temp}, %{high: h, low: l} = state) do
    new_high = if h == nil or temp > h, do: temp, else: h
    new_low = if l == nil or temp < l, do: temp, else: l
    {:noreply, %{high: new_high, low: new_low}}
  end


  def handle_call(:get_temps, _from, state) do
    {:reply, state, state}
  end
end
