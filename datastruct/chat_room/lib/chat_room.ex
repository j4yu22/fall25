defmodule ChatRoom do
  @moduledoc """
  Public API for controlling chat rooms.
  """

  alias ChatRoom.RoomSupervisor
  alias ChatRoom.Room

  def start_room(name), do: RoomSupervisor.start_room(name)
  def join(room, user), do: Room.join(room, user)
  def send(room, user, msg), do: Room.send_message(room, user, msg)
  def history(room),       do: Room.history(room)
end
