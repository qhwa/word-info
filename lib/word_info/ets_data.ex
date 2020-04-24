defmodule WordInfo.EtsData do
  @moduledoc false

  @external_resource syl_data = "priv/syllables.txt"
  @external_resource ipa_data = "priv/cmudict-0.7b-ipa.txt"
  @external_resource arp_data = "priv/cmudict-0.7b.txt"
  @external_resource frq_data = "priv/brown-frequency.txt"

  def generate do
    {:ok, _} =
      %{}
      |> merge(read_syllables(), :syllables)
      |> merge(read_ipas(), :ipa)
      |> merge(read_arpabets(), :arpabet)
      |> merge(read_frequencies(), :frequency)
      |> to_ets_dump()

    :ok
  end

  defp read_syllables, do: read(unquote(syl_data))
  defp read_ipas, do: read(unquote(ipa_data))
  defp read_arpabets, do: read(unquote(arp_data))

  defp read_frequencies,
    do:
      read(
        unquote(frq_data),
        fn {w, id} ->
          {w |> String.downcase() |> String.trim(), id + 1}
        end,
        with_index: true,
        split: false
      )

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

  defp merge(origin, map, key) do
    map
    |> Enum.reduce(origin, fn {word, data}, acc ->
      Map.update(acc, String.downcase(word), %{key => data}, &Map.put(&1, key, data))
    end)
  end

  defp to_ets_dump(big_map) do
    tab = :ets.new(:word_info, [])
    for record <- big_map, do: :ets.insert(tab, record)

    dumped = db_file()
    :ets.tab2file(tab, dumped)

    {:ok, to_string(dumped)}
  end

  @db_dir_env_key "WORD_INFO_DATA_DIR"
  @db_name "word_info.tab"

  def db_file, do: Path.join(db_dir(), @db_name) |> String.to_charlist()
  def db_dir, do: System.get_env(@db_dir_env_key, :code.priv_dir(:word_info) |> to_string())
end

WordInfo.EtsData.generate()
