defmodule ChatRoom.RoomSupervisorTest do
  use ExUnit.Case

  test "starting a room creates a supervised process" do
    assert {:ok, pid} = ChatRoom.RoomSupervisor.start_room("super-room")
    assert Process.alive?(pid)
  end
end
