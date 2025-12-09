defmodule ChatRoomTest do
  use ExUnit.Case

  test "full flow through the public API" do
    {:ok, _pid} = ChatRoom.start_room("main")
    ChatRoom.join("main", "jay")
    ChatRoom.send("main", "jay", "hey there")

    [%{user: "jay", message: "hey there"}] =
      ChatRoom.history("main")
      |> Enum.map(&Map.take(&1, [:user, :message]))
  end
end
