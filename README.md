# CMU Dictionary with IPA

This is an exlixir wrapper of [cmudict-ipa](https://github.com/menelik3/cmudict-ipa), which uses the [CMU dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) as its original data source.

## Usage

### Syllables 

```elixir
iex> CmudictIPA.syllables("traditional")
["tra", "di", "tion", "al"]
```

### IPA pronunciation phonemes

```elixir
iex> CmudictIPA.pronounce("halfway")
["ˈhæfˈweɪ"]
```

### Word frequency

```elixir
iex> CmudictIPA.frequency("scientist")
5499
```

The number `5499` means it's ranked at 5499 on frequncy.

