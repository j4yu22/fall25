defmodule ChatRoom.Application do
  @moduledoc """
  OTP application entry point for the ChatRoom system.
  """

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: ChatRoom.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: ChatRoom.RoomSupervisor}
    ]

    opts = [strategy: :one_for_one, name: ChatRoom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
