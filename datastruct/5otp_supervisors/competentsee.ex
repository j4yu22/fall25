"""
In your editor, implement a supervisor to monitor uptime of children. It should:

Restart children after a crash.

Log uptime statistics when each child terminates.
"""

defmodule UptimeWorker do
  use GenServer

  # start the worker and record the start time
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{start_time: :os.system_time(:second)}, [])
  end

  def init(state), do: {:ok, state}

  # simulate a random crash after a few seconds
  def handle_info(:crash, state) do
    raise "simulated crash"
  end

  def handle_info(_, state), do: {:noreply, state}
end


defmodule UptimeSupervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      %{
        id: UptimeWorker,
        start: {UptimeWorker, :start_link, [[]]},
        restart: :permanent,
        shutdown: 5000,
        type: :worker
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end


defmodule MonitorApp do
  def start do
    {:ok, _pid} = UptimeSupervisor.start_link(nil)

    # monitor worker crashes
    Process.sleep(3000)
    send(Process.whereis(UptimeWorker), :crash)
  end
end
