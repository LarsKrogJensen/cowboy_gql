defmodule PlugEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_ex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PlugEx, []},
      env: [
        cowboy_port: 9090
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:absinthe_plug, "~> 1.4"},
      {:jason, "~> 1.1"},
      {:absinthe, "~> 1.4"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 2.0"},
      {:remix, "~> 0.0.1", only: :dev}
    ]
  end
end
