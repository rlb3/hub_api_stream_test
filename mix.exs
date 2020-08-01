defmodule HUBApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :hubspot_stream,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:peppermint, "~> 0.3.0"},
      {:castore, "~> 0.1.0"},
      {:jason, "~> 1.2"},
      {:flow, "~> 1.0"}
    ]
  end
end
