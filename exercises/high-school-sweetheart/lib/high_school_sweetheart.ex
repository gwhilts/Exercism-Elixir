defmodule HighSchoolSweetheart do

  @heart """
              ******       ******
            **      **   **      **
          **         ** **         **
         **            *            **
         **                         **
         **     F1 L1  +  F2 L2     **
          **                       **
            **                   **
              **               **
                **           **
                  **       **
                    **   **
                      ***
                       *
         """

  def first_letter(name) do
    String.trim(name)
    |> String.slice(0..0)
  end

  def initial(name) do
    "#{ String.upcase(first_letter(name)) }."
  end

  def initials(full_name) do
    [first, last] = String.split(full_name)
    "#{initial(first)} #{initial(last)}"
  end

  def pair(full_name1, full_name2) do
    @heart
    |> String.replace("F1 L1", initials(full_name1))
    |> String.replace("F2 L2", initials(full_name2))
  end
end
