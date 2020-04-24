defmodule WordInfo.Dictionary do
  @moduledoc false

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

  @spec lookup(binary, atom) :: String.t() | :unknown
  def lookup(word, key) do
    Agent.get(__MODULE__, fn table ->
      case :ets.lookup(table, String.downcase(word)) do
        [{_, %{^key => data}}] -> data
        _ -> :unknown
      end
    end)
  end
end
