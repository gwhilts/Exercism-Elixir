defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(list) :: {:error, String.t()} | {:ok, list}
  @callback handle_frame(%DancingDots.Dot{}, Integer, list) :: %DancingDots.Dot{}


end

defmodule DancingDots.Flicker do
  # Please implement the module
end

defmodule DancingDots.Zoom do
  # Please implement the module
end
