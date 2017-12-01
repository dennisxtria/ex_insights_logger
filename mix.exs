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
    ]
  end
  
  def elixirc_paths(:test) do
    ["lib", "deps/ex_insights/test/test_helper"]
  end

  def elixirc_paths(_) do
    ["lib"] 
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [

      applications: [:logger, :ex_insights]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      #{:ex_insights, git: "https://github.com/StoiximanServices/ex_insights.git"}
      {:ex_insights, git: "https://github.com/k11sths/ex_insights.git", branch: "test-helper"}
    ]
  end
end
