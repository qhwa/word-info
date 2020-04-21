defmodule CmudictIpa do
  @moduledoc """
  Get the pronunciation and frequency information of a word.
  """

  alias CmudictIpa.Data

  @doc """
  Fetch the pronunciation of a word from CMU dictionary, with IPA pronu

  ## Examples

      iex> CmudictIpa.pronounce("world")
      ["ˈwɝːld"]

      iex> CmudictIpa.pronounce("semi-colon")
      ["ˈsɛmiːˈkoʊlən,", "ˈsɛməˈkoʊlən"]

  """
  @spec pronounce(binary) :: [String.t()]
  def pronounce(word) do
    Map.get(Data.pronunciations(), word |> String.upcase())
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
