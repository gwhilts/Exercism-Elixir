defmodule Username do
  @allowed_chars 'abcdefghijklmnopqrstuvwxyz_ßäöü'
  def sanitize(username) do
    username
    |> Enum.filter( &( Enum.member?(@allowed_chars, &1)))
    |> Enum.map( &un_germanize/1 )
    |> List.flatten()
  end

  defp un_germanize(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> char
    end
  end

end
