defmodule CmudictIpa do
  @moduledoc """
  Get the pronunciation and frequency information of a word.
  """

  alias CmudictIpa.Data

  @doc """
  Split the headword into syllables
  """
  def syllables(word) do
    Map.get(Data.syllables(), word |> String.downcase())
  end

  @doc """
  Fetch the pronunciation of a word from CMU dictionary, with IPA pronu

  ## Examples

      iex> CmudictIpa.ipa("world")
      ["ˈwɝːld"]

      iex> CmudictIpa.ipa("semi-colon")
      ["ˈsɛmiːˈkoʊlən,", "ˈsɛməˈkoʊlən"]

  """
  @spec ipa(binary) :: [String.t()]
  def ipa(word) do
    Map.get(Data.ipa_pronun(), word |> String.upcase())
  end

  @doc """
  Fetch the frequency rating of a word.

  The rating is based on data from [cmudict-ipa](https://github.com/menelik3/cmudict-ipa), which
  uses [Brown Corpus of American English](https://archive.org/details/BrownCorpus) originally.

  ## Returnss

  * `:unknown` if not found in the dictionary
  * an rating number, the smaller the frequenter. For instance, `1` is the most used word `"THE"`.

  ## Examples

      iex> CmudictIpa.frequncy("traditional")
      1365

      iex> CmudictIpa.frequncy("some-unknown-word")
      :unkown
  """
  @spec frequncy(binary) :: :unkown | pos_integer
  def frequncy(word) do
    Map.get(Data.frequencies(), String.upcase(word), :unkown)
  end
end
