defmodule WordInfoTest.EtsDataTest do
  use ExUnit.Case
  alias WordInfo.EtsData

  test "it works with system env" do
    System.put_env("WORD_INFO_DATA_DIR", "/tmp")
    assert EtsData.db_file() == '/tmp/word_info.tab'
  end

  test "it dumps ETS data" do
    System.put_env("WORD_INFO_DATA_DIR", "/tmp")
    :ok = EtsData.generate()

    assert File.exists?("/tmp/word_info.tab")
  end
end
