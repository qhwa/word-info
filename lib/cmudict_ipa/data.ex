defmodule CmudictIpa.Data.Reader do
  @moduledoc false
  def read(path, process \\ &{hd(&1), tl(&1)}) do
    Path.join([__DIR__, "../../priv/", path])
    |> File.stream!()
    |> Stream.reject(&String.starts_with?(&1, "#"))
    |> Stream.reject(&String.match?(&1, ~r/^\s+$/))
    |> Stream.map(&String.split/1)
    |> Stream.map(process)
    |> Map.new()
    |> Macro.escape()
  end
end

defmodule CmudictIpa.Data do
  @moduledoc false

  import __MODULE__.Reader

  arpabet_data = read("cmudict-0.7b.txt")

  @doc """
  ARPABet pronunciation data from [CMU Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict)
  """
  @spec arpabet() :: %{required(String.t()) => [String.t()]}
  def arpabet, do: unquote(arpabet_data)

  ## IPA
  ipa_pronun_data = read("cmudict-0.7b-ipa.txt")

  @doc """
  Pronunciation data from [CMU Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) via https://github.com/menelik3/cmudict-ipa
  """
  @spec ipa_pronun() :: %{required(String.t()) => [String.t()]}
  def ipa_pronun, do: unquote(ipa_pronun_data)

  frequncy_data =
    read("brown-frequency-list-with-ipa.txt", fn [freq, w | _] ->
      {w, String.to_integer(freq)}
    end)

  @doc """
  Frequency data from [Brown Corpus of American English](https://archive.org/details/BrownCorpus) via https://github.com/menelik3/cmudict-ipa
  """
  @spec frequencies() :: %{required(String.t()) => pos_integer}
  def frequencies, do: unquote(frequncy_data)

  syllables_data = read("syllables.txt")

  @doc """
  Syllables data from Gary Darby's DFF project.
  http://www.delphiforfun.org/programs/Syllables.htm
  """
  def syllables, do: unquote(syllables_data)
end
