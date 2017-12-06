defmodule ExInsightsLogger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_insights_logger,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),

      #Docs
      name: "ExInsightsLogger",
      source_url: "https://github.com/dennisxtria/ex_insights_logger",
    ]
  end

  def elixirc_paths(:test) do
    ["lib", "deps/ex_insights/test/test_helper"]
  end

  def elixirc_paths(_) do
    ["lib"]
  end

  def application do
    [
      applications: [:logger, :ex_insights]
    ]
  end

  defp deps do
    [
      {:ex_insights, "~> 0.4"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
    ]
  end
end
