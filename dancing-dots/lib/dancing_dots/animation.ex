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
      0 -> %{dot | opacity: dot.opacity / 2}
      _ -> dot
    end
  end

end

defmodule DancingDots.Zoom do
  # Please implement the module
end
