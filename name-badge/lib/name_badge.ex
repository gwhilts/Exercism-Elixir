defmodule NameBadge do

  def print(id, name, department), do: id_string(id) <> "#{name}" <> dept_string(department)

  defp id_string(id) do
    if id, do: "[#{id}] - ", else: ""
  end

  defp dept_string(department) do
    if department,  do: " - #{String.upcase(department)}", else: " - OWNER"
  end
end
