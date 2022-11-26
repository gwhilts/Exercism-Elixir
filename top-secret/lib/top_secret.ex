defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, msg)  do
    {ast, update_msg(ast, msg)}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_ast, msg_parts} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    msg_parts |> Enum.reverse() |> Enum.join()
  end

  defp update_msg({:defp, _, args}, msg), do: [code_from(args) | msg]
  defp update_msg({:def,  _, args}, msg), do: [code_from(args) | msg]
  defp update_msg(_ast, msg),             do: msg

  defp code_from(args) do
    [{name, _, arglist},_] = args
    count = if arglist, do: length(arglist), else: 0
    cond do
      name == :when -> code_from(arglist)
      count == 0 -> ""
      true -> Atom.to_string(name) |> String.slice(0..(count - 1))
    end
  end

end
