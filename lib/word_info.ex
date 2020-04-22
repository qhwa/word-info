defmodule WordInfo do
  @moduledoc """
  Get the pronunciation and frequency information of a word.

  ### Syllables 

  ```elixir
  iex> WordInfo.syllables("tradition")
  ["tra", "di", "tion"]
  ```

  ### ARPABET pronunciation phonemes

  ```elixir
  iex> WordInfo.arpabet("halfway")
  ["HH", "AE1", "F", "W", "EY1"]
  ```

  ### IPA pronunciation phonemes

  ```elixir
  iex> WordInfo.ipa("halfway")
  ["ˈhæfˈweɪ"]
  ```

  ### Word frequency

  ```elixir
  iex> WordInfo.frequency("scientist")
  5499
  ```

  The number `5499` means it's ranked at 5499 on frequncy.
  """

  alias WordInfo.Data

  @doc """
  Split the headword into syllables
  """
  def syllables(word) do
    Map.get(Data.syllables(), word |> String.downcase())
  end

  @doc """
  Fetch the pronunciation of a word from CMU dictionary, in ARPABET format

  See also: https://en.wikipedia.org/wiki/ARPABET

  ## Examples

      iex> WordInfo.arpabet("world")
      ["W", "ER1", "L", "D"]

      iex> WordInfo.arpabet("semi-colon")
      ["S", "EH1", "M", "IY0", "K", "OW1", "L", "AH0", "N"]
  """
  @spec arpabet(binary) :: [String.t()] | :unkown
  def arpabet(word) do
    Map.get(Data.arpabet(), word |> String.upcase(), :unkown)
  end

  @doc """
  Fetch the pronunciation of a word from CMU dictionary, with IPA pronu

  ## Examples

      iex> WordInfo.ipa("world")
      ["ˈwɝːld"]

      iex> WordInfo.ipa("semi-colon")
      ["ˈsɛmiːˈkoʊlən,", "ˈsɛməˈkoʊlən"]

  """
  @spec ipa(binary) :: [String.t()] | :unknown
  def ipa(word) do
    Map.get(Data.ipa_pronun(), word |> String.upcase(), :unknown)
  end

  @doc """
  Fetch the frequency rating of a word.

  The rating is based on data from [cmudict-ipa](https://github.com/menelik3/cmudict-ipa), which
  uses [Brown Corpus of American English](https://archive.org/details/BrownCorpus) originally.

  ## Returnss

  * `:unknown` if not found in the dictionary
  * an rating number, the smaller the frequenter. For instance, `1` is the most used word `"THE"`.

  ## Examples

      iex> WordInfo.frequency("traditional")
      1365

      iex> WordInfo.frequency("some-unknown-word")
      :unkown
  """
  @spec frequency(binary) :: :unkown | pos_integer
  def frequency(word) do
    Map.get(Data.frequencies(), String.upcase(word), :unkown)
  end
end
