defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:error, error} | {:ok, opts}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end

end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    case rem(frame_number, 4) do
      0 -> %{ dot | opacity: dot.opacity / 2 }
      _ -> dot
    end
  end

end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    if is_integer(opts[:velocity]) do
      {:ok, opts}
    else
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    delta = (frame_number - 1) * opts[:velocity]
    %{ dot | radius: dot.radius + delta }
  end
end
