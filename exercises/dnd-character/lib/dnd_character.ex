defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  @abilities ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a
  defstruct @abilities

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div((score - 10), 2)
  end

  @spec ability :: pos_integer()
  def ability do
    (for _ <- 1..4, into: [], do: :rand.uniform(6))
    |> Enum.sort()
    |> Enum.drop(1)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    char = Enum.reduce(@abilities, %DndCharacter{}, fn(a, char) -> %{char | a => DndCharacter.ability} end)
    %{char | hitpoints: 10 + modifier(char.constitution)}
  end

end
