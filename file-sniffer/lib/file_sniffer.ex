defmodule FileSniffer do
  alias ElixirSense.Providers.Suggestion.Reducers.Bitstring
  @media_types [
    %{ext: "bmp", type: "image/bmp", sig: <<0x42, 0x4D>>},
    %{ext: "exe", type: "application/octet-stream", sig: <<0x7F, 0x45, 0x4C, 0x46>>},
    %{ext: "gif", type: "image/gif", sig: <<0x47, 0x49, 0x46>>},
    %{ext: "jpg", type: "image/jpg", sig: <<0xFF, 0xD8, 0xFF>>},
    %{ext: "png", type: "image/png", sig: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>}
  ]

  @spec type_from_extension(String) :: String
  def type_from_extension(extension) do
    # find a media type with given extention |> return its type
    Enum.find(@media_types, %{}, &(&1[:ext] == extension)) |> Map.get(:type)
  end

  @spec type_from_binary(Bitstring) :: String
  def type_from_binary(file_binary) do
    # find a media type with whose sig the given file_binary begins |> return its type
    Enum.find(@media_types, %{}, &(String.starts_with? file_binary, &1[:sig])) |> Map.get(:type)
  end

  @spec verify(Bitstring, String) :: {:ok, String} | {:error, String}
  def verify(file_binary, extension) do
    # when the file bin type and extention type are the same, return {:ok, type}, otherwise {:error, ...}
    case {type_from_binary(file_binary), type_from_extension(extension)} do
      {type, type} -> {:ok, type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end

end
