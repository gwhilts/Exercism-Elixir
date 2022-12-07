defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(args) do

  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(pid) do

  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(pid) do

  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(pid, priority_number \\ nil) do

  end

  @spec reset_state(pid()) :: :ok
  def reset_state(pid) do

  end

  # Server callbacks
end
