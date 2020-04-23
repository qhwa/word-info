# WordInfo

This is an [elixir] dictionary library providing information for words, often refered as "headword" in ligual domains.

This library compile dictionary data into codes for accurater results. There are some libraries using algorithms to get results. However, so far the results are not good enough compared to dictionaries. It may change in future and hopefully we'll switch to a better approach.

## Usage

### Frequency

```elixir
iex> WordInfo.frequency("word")
340
```

`340` means this word is the top 340 frequently used words.

### ARPABET pronunciation

```elixir
iex> WordInfo.arpabet("mix")
["M", "IH1", "K", "S"]
```

### IPA pronunciation

```elixir
iex> WordInfo.ipa("exsiting")
["ɪgˈzɪstɪŋ"]
```

### Syllables

```elixir
iex> WordInfo.syllables("syllable")
["syl", "la", "ble"]
```

Please refer to [online document](http://hexdocs.pm/word_info) for more information.


## Acknowledgements

Here are the data sources of this library:

* syllables - 43,000 words from [Gary Darby's DFF project](http://www.delphiforfun.org/programs/Syllables.htm)
* [IPA] style pronunciation - 125,000 word pronunciations from [cmudict-ipa] project
* [ARPABET] style pronunciation - 130,000 word pronunciations from [CMU Dict]
* frequency - usage frequency ranking of 33,000+ words from [Brown Corpus of American English] and [cmudict-ipa]

Without these open data, this library is impossible.

[Elixir]: https://elixir-lang.org
[ARPABET]: https://en.wikipedia.org/wiki/ARPABET
[IPA]: https://en.wiktionary.org/wiki/Wiktionary:IPA_pronunciation_key
[CMU Dict]: http://www.speech.cs.cmu.edu/cgi-bin/cmudict
[Brown Corpus of American English]: https://archive.org/details/BrownCorpus
[cmudict-ipa]: https://github.com/menelik3/cmudict-ipa
