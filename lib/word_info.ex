defmodule WordInfo do
  @moduledoc """
  Get the pronunciation and frequency information of a word.

  **Syllables**

  ```elixir
  iex> WordInfo.syllables("tradition")
  ["tra", "di", "tion"]
  ```

  **ARPABET pronunciation phonemes**

  ```elixir
  iex> WordInfo.arpabet("halfway")
  ["HH", "AE1", "F", "W", "EY1"]
  ```

  **IPA pronunciation phonemes**

  ```elixir
  iex> WordInfo.ipa("halfway")
  ["ˈhæfˈweɪ"]
  ```

  **Word frequency**

  ```elixir
  iex> WordInfo.frequency("scientist")
  5499
  ```

  The number `5499` means it's ranked at 5499 on frequncy.

  ## Acknowledgements

  Here are the data sources of this library, without which this library is impossible.

  * syllables - 43,000 words from [Gary Darby's DFF project](http://www.delphiforfun.org/programs/Syllables.htm)
  * [IPA] style pronunciation - 125,000 word pronunciations from [cmudict-ipa] project
  * [ARPABET] style pronunciation - 130,000 word pronunciations from [CMU Dict]
  * frequency - usage frequency ranking of 33,000+ words from [Brown Corpus of American English] and [cmudict-ipa]

  [ARPABET]: https://en.wikipedia.org/wiki/ARPABET
  [IPA]: https://en.wiktionary.org/wiki/Wiktionary:IPA_pronunciation_key
  [CMU Dict]: http://www.speech.cs.cmu.edu/cgi-bin/cmudict
  [Brown Corpus of American English]: https://archive.org/details/BrownCorpus
  [cmudict-ipa]: https://github.com/menelik3/cmudict-ipa
  """

  alias WordInfo.Data

  @doc """
  Split the headword into syllables

  ## Returnss

  * `:unknown` if not found in the dictionary
  * A list of syllables.

  ## Example

  ```elixir
  iex> WordInfo.syllables("edition")
  ["e", "di", "tion"]

  iex> WordInfo.syllables("something-not-in-the-dictionary")
  :unknown
  ```

  """
  @spec syllables(binary) :: [String.t()] | :unknown
  def syllables(word) do
    Map.get(Data.syllables(), word |> String.downcase(), :unknown)
  end

  @doc """
  Fetch the pronunciation of a word from CMU dictionary, in ARPABET format

  See also: https://en.wikipedia.org/wiki/ARPABET

  ## Returnss

  * `:unknown` if not found in the dictionary
  * A list of ARPABET phonemes.

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

  ## Returnss

  * `:unknown` if not found in the dictionary
  * A list of IPA pronunciations, all for the full word.

  ## Examples

      iex> WordInfo.ipa("world")
      ["ˈwɝːld"]

      iex> WordInfo.ipa("semi-colon")
      ["ˈsɛmiːˈkoʊlən,", "ˈsɛməˈkoʊlən"]

      iex> WordInfo.ipa("lalalal")
      :unknown
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
