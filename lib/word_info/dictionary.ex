defmodule WordInfo.Dictionary do
  @moduledoc false

  use Agent

  def start_link(_),
    do: Agent.start_link(&load/0, name: __MODULE__)

  defp load do
    {:ok, table} = :ets.file2tab(WordInfo.EtsData.db_file())
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
