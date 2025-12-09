defmodule ChatRoom.Registry do
  @moduledoc """
  Helper functions for interacting with the room registry.
  """

  def via(name) do
    {:via, Registry, {ChatRoom.Registry, name}}
  end
end
