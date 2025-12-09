defmodule ChatRoom.RoomSupervisor do
  @moduledoc """
  Supervisor responsible for creating chat rooms dynamically.
  """

  def start_room(name) do
    spec = {ChatRoom.Room, name}
    DynamicSupervisor.start_child(ChatRoom.RoomSupervisor, spec)
  end
end
