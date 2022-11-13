defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    years = case planet do
      :earth -> earth_years(seconds)
      :mercury -> earth_years(seconds) / 0.2408467
      :venus -> earth_years(seconds) / 0.61519726
      :mars -> earth_years(seconds) / 1.8808158
      :saturn -> earth_years(seconds) / 29.447498
      :jupiter -> earth_years(seconds) / 11.862615
      :uranus -> earth_years(seconds) / 84.016846
      :neptune -> earth_years(seconds) / 164.79132
      _ -> nil
    end

    case years do
      nil -> {:error, "not a planet"}
      _ -> {:ok, years}
    end
  end

  defp earth_years(seconds) do
    seconds / 31557600
  end
end
