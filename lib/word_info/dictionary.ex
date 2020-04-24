defmodule WordInfo.Dictionary do
  use Agent

  def start_link(_) do
    Agent.start_link(&load/0, name: __MODULE__)
  end

  defp load do
    {:ok, table} =
      Path.join(:code.priv_dir(:word_info), "merged.tab")
      |> String.to_charlist()
      |> :ets.file2tab()

    table
  end

  def lookup(word, key) do
    Agent.get(__MODULE__, fn table ->
      case :ets.lookup(table, String.downcase(word)) do
        [{_, %{^key => data}}] -> data
        _ -> :unknown
      end
    end)
  end
end
