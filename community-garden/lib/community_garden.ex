# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn() -> %{next_id: 1, plots: %{} } end)
  end
  def list_registrations(pid) do
    Agent.get pid, &Map.get(&1, :plots) |> Map.values()
  end

  def register(pid, register_to) do
    id = Agent.get pid, &Map.get(&1, :next_id)
    plot = %Plot{plot_id: id, registered_to: register_to}
    Agent.update(pid, &( %{&1 | plots: Map.put(&1[:plots], id, plot), next_id: id + 1}))
    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, &%{&1 | plots: Map.delete(&1.plots, plot_id)})
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, &Map.get(&1[:plots], plot_id)) || {:not_found, "plot is unregistered"}
  end
end
