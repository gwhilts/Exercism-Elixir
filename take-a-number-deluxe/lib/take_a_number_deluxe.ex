defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State, as: State

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(opts) do
    GenServer.start(__MODULE__, opts)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(pid) do
    GenServer.call(pid, :state)
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
    GenServer.cast(pid, :reset)
  end

  # Server callbacks

  @impl GenServer
  def init(opts) do
    case State.new(opts[:min_number], opts[:max_number], opts[:auto_shutdown_timeout] || :infinity) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, msg} -> {:stop, msg}
    end
  end

  @impl GenServer
  def handle_call(:state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, num, new_state} ->  {:reply, {:ok, num}, new_state, state.auto_shutdown_timeout}
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, num, new_state} -> {:reply, {:ok, num}, new_state, state.auto_shutdown_timeout}
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, state) do
    {_, new_state} = State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
