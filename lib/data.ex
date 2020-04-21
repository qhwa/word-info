defmodule CmudictIpa.Data do
  parse = fn path, process ->
    Path.join([__DIR__, "../priv/", path])
    |> File.stream!()
    |> Stream.map(&String.split/1)
    |> Stream.map(process)
    |> Map.new()
    |> Macro.escape()
  end

  pronun_data = parse.("cmudict-0.7b-ipa.txt", fn [w | prons] -> {w, prons} end)

  @doc """
  Pronunciation data from [CMU Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) via https://github.com/menelik3/cmudict-ipa
  """
  @spec pronunciations() :: %{required(String.t()) => [String.t()]}
  def pronunciations, do: unquote(pronun_data)

  frequncy_data =
    parse.("brown-frequency-list-with-ipa.txt", fn [freq, w | _] ->
      {w, String.to_integer(freq)}
    end)

  @doc """
  Frequency data from [Brown Corpus of American English](https://archive.org/details/BrownCorpus) via https://github.com/menelik3/cmudict-ipa
  """
  @spec frequencies() :: %{required(String.t()) => pos_integer}
  def frequencies, do: unquote(frequncy_data)
end
