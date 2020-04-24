defmodule WordInfo.EtsData do
  @moduledoc false
  defp read(src, process \\ &{hd(&1), tl(&1)}, opts \\ []) do
    with_index =
      if Keyword.get(opts, :with_index) do
        &Stream.with_index(&1)
      else
        & &1
      end

    splitter =
      if Keyword.get(opts, :split, true) do
        &String.split/1
      else
        & &1
      end

    src
    |> File.stream!()
    |> Stream.reject(&String.starts_with?(&1, "#"))
    |> Stream.reject(&String.match?(&1, ~r/^\s+$/))
    |> with_index.()
    |> Stream.map(splitter)
    |> Stream.map(process)
  end

  def generate do
    syl_map = read("priv/syllables.txt")
    ipa_map = read("priv/cmudict-0.7b-ipa.txt")
    arp_map = read("priv/cmudict-0.7b.txt")

    frq_map =
      read(
        "priv/brown-frequency.txt",
        fn {w, id} ->
          {w |> String.downcase() |> String.trim(), id + 1}
        end,
        with_index: true,
        split: false
      )

    %{}
    |> merge(syl_map, :syllables)
    |> merge(ipa_map, :ipa)
    |> merge(arp_map, :arpabet)
    |> merge(frq_map, :frequency)
    |> to_ets_dump()
  end

  defp merge(origin, map, key) do
    map
    |> Enum.reduce(origin, fn {word, data}, acc ->
      Map.update(acc, String.downcase(word), %{key => data}, &Map.put(&1, key, data))
    end)
  end

  defp to_ets_dump(big_map) do
    tab = :ets.new(:word_info, [])
    for record <- big_map, do: :ets.insert(tab, record)
    :ets.tab2file(tab, 'priv/merged.tab')
  end
end

WordInfo.EtsData.generate()
