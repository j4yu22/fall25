defmodule ChatRoom.Room do
  @moduledoc """
  A chat room process. Stores members and message history.
  """

  use GenServer

  ## PUBLIC API

  def start_link(name) do
    GenServer.start_link(__MODULE__, %{name: name}, name: ChatRoom.Registry.via(name))
  end

  def join(room, user) do
    GenServer.call(ChatRoom.Registry.via(room), {:join, user})
  end

  def send_message(room, user, message) do
    GenServer.call(ChatRoom.Registry.via(room), {:send_message, user, message})
  end

  def history(room) do
    GenServer.call(ChatRoom.Registry.via(room), :history)
  end

  ## SERVER CALLBACKS

  def init(state) do
    {:ok, Map.merge(state, %{members: MapSet.new(), messages: []})}
  end

  def handle_call({:join, user}, _from, state) do
    members = MapSet.put(state.members, user)
    {:reply, :ok, %{state | members: members}}
  end

  def handle_call({:send_message, user, msg}, _from, state) do
    entry = %{user: user, message: msg, timestamp: System.system_time(:millisecond)}
    {:reply, :ok, %{state | messages: [entry | state.messages]}}
  end

  def handle_call(:history, _from, state) do
    {:reply, Enum.reverse(state.messages), state}
  end
end
