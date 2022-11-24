defmodule FileSniffer do
  @media_types [
    %{ext: "bmp", media_type: "image/bmp", signature: <<0x42, 0x4D>>},
    %{ext: "exe", media_type: "application/octet-stream", signature: <<0x7F, 0x45, 0x4C, 0x46>>},
    %{ext: "gif", media_type: "image/gif", signature: <<0x47, 0x49, 0x46>>},
    %{ext: "jpg", media_type: "image/jpg", signature: <<0xFF, 0xD8, 0xFF>>},
    %{ext: "png", media_type: "image/png", signature: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>}
  ]
  def type_from_extension(extension) do
    pluck(:ext, extension) |> Map.get(:media_type)
  end

  def type_from_binary(file_binary) do
    sig = sig_scan(file_binary)
    pluck(:signature, sig) |> Map.get(:media_type)
  end

  def verify(file_binary, extension) do
    if type_from_binary(file_binary) == type_from_extension(extension) do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end

  @spec pluck(atom(), any) :: Map
  def pluck(key, val), do: Enum.find(@media_types, %{}, fn(map) -> map[key] == val end)

  def sig_scan(bin) do
    cond do
      String.contains?(bin, <<0x42, 0x4D>>) -> <<0x42, 0x4D>>
      String.contains?(bin, <<0x7F, 0x45, 0x4C, 0x46>>) -> <<0x7F, 0x45, 0x4C, 0x46>>
      String.contains?(bin, <<0x47, 0x49, 0x46>>) -> <<0x47, 0x49, 0x46>>
      String.contains?(bin, <<0xFF, 0xD8, 0xFF>>) -> <<0xFF, 0xD8, 0xFF>>
      String.contains?(bin, <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>) -> <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
      true -> nil
    end
  end
end
