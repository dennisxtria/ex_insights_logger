defmodule ExInsightsLogger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_insights_logger,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0", only: :test},
      {:plug, "~> 1.0", only: :test}
    ]
  end
end
