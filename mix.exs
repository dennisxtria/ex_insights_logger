defmodule ExInsightsLogger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_insights_logger,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      name: "ExInsightsLogger",
      description: description(),
      source_url: "https://github.com/dennisxtria/ex_insights_logger",
      elixirc_paths: elixirc_paths(Mix.env),
      # package: package,
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
      {:ex_insights, "~> 0.3.1"},
      #{:ex_insights, git: "https://github.com/dennisxtria/ex_insights.git", branch: "test-helper-moved"},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
    ]
  end

  defp description do
    """
    Elixir custom Logger that automatically uploads your application logs on Azure Application Insights.
    """
  end

  # defp package do
  #   [
  #     maintainers: ["bottlenecked"],
  #     licenses: ["MIT"],
  #     links: %{"GitHub" => "https://github.com/dennisxtria/ex_insights_logger"}
  #   ]
  # end



end
