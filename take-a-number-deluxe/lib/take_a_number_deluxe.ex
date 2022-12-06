defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  # REDO
  # Really ought to wipe and re-attempt this ex from scratch. Got everything working
  # eventually, but seriously fumbled and cheated my way there.

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(pid) do
    GenServer.call(pid, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(pid) do
    GenServer.call(pid, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(pid, priority_number \\ nil) do
    GenServer.call(pid, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(pid) do
    GenServer.cast(pid, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(args) do
    timeout = args[:auto_shutdown_timeout] || :infinity
    case State.new(args[:min_number], args[:max_number], timeout) do
      {:ok, state}  -> {:ok, state, timeout}
      {:error, reason} -> {:stop, reason}
    end
  end

  # def handle_call(:msg, _from, state), do: {:reply, reply, new_state} | {:error, reason}
  @impl GenServer
  def handle_call(:report_state, _from, state), do: {:reply, state, state, state.auto_shutdown_timeout}

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, num, new_state} -> {:reply, {:ok, num}, new_state, state.auto_shutdown_timeout}
      {:error, msg} -> {:reply, {:error, msg}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, num, new_state} -> {:reply, {:ok, num}, new_state, state.auto_shutdown_timeout}
      {:error, msg} -> {:reply, {:error, msg}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:ok, new_state} = State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, new_state, state.auto_shutdown_timeout}
  end


  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state), do: {:noreply, state, state.auto_shutdown_timeout}
end
