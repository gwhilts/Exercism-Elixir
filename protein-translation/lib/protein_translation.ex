defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna), do: of_rna(rna, [])
  defp of_rna(rna, list) when rna == "", do: {:ok, Enum.reverse list}
  defp of_rna(rna, list) do
    {head, rest} = String.split_at(rna, 3)
    case of_codon(head) do
      {:ok, "STOP"} -> {:ok, Enum.reverse list}
      {:ok, protein} -> of_rna(rest, [protein | list])
      {:error, _} -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given an RNA codon, return its associated protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case @codons[codon] do
      nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
