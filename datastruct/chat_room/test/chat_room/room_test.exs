defmodule ChatRoom.RoomTest do
  use ExUnit.Case

  setup do
    {:ok, _pid} = ChatRoom.Room.start_link("test-room")
    :ok
  end

  test "joining a room adds a member" do
    assert :ok == ChatRoom.Room.join("test-room", "jay")
  end

  test "sending a message stores it in history" do
    ChatRoom.Room.join("test-room", "jay")
    ChatRoom.Room.send_message("test-room", "jay", "hello")

    history = ChatRoom.Room.history("test-room")
    assert [%{user: "jay", message: "hello"}] = history |> Enum.map(&Map.take(&1, [:user, :message]))
  end
end
