"""
In your editor, write a stateful process to manage the inventory of a small store, including adding stock and reducing stock for sales.
"""

defmodule StoreInventory do
  use GenServer

  """
  a simple stateful process that tracks and updates store inventory

  functions:
    start_link/0 - starts the inventory process with an empty map
    add_stock/2 - adds a certain amount of an item
    sell_item/2 - reduces the amount of an item when sold
    get_inventory/0 - retrieves the current inventory
  """

  # start the process
  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end


  # add stock to an item
  def add_stock(item, amount) do
    GenServer.cast(__MODULE__, {:add_stock, item, amount})
  end


  # reduce stock when an item is sold
  def sell_item(item, amount) do
    GenServer.cast(__MODULE__, {:sell_item, item, amount})
  end


  # check current inventory
  def get_inventory do
    GenServer.call(__MODULE__, :get_inventory)
  end


  # server callbacks
  def init(initial_state) do
    {:ok, initial_state}
  end


  def handle_cast({:add_stock, item, amount}, state) do
    new_state = Map.update(state, item, amount, &(&1 + amount))
    {:noreply, new_state}
  end


  def handle_cast({:sell_item, item, amount}, state) do
    new_state =
      case Map.get(state, item, 0) do
        current when current >= amount -> Map.put(state, item, current - amount)
        _ -> state  # do nothing if not enough stock
      end

    {:noreply, new_state}
  end


  def handle_call(:get_inventory, _from, state) do
    {:reply, state, state}
  end
end
