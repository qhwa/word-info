defmodule WordInfo.MixProject do
  use Mix.Project

  def project do
    [
      app: :word_info,
      version: "0.1.0",
      elixir: ">= 1.9.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: docs(),
      package: package(),
      source_url: "https://github.com/qhwa/word-info"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.12", only: :test},
      {:ex_doc, "~> 0.21", only: [:dev, :doc], runtime: false},
      {:credo, "~> 1.3", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ~w[README.md]
    ]
  end

  defp package do
    [
      name: "word_info",
      files: ~w[lib mix.exs priv],
      licenses: ["MIT"],
      links: %{
        "github" => "https://github.com/qhwa/word-info"
      }
    ]
  end
end
