defmodule KeyCDN.MixProject do
  use Mix.Project

  def project do
    [
      app: :keycdn,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
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
      {:hackney, "~> 1.17.0"},
      {:telemetry, "~> 0.4.2"},
      {:jason, "~> 1.2.2"},
      {:ex_doc, "~> 0.23", only: [:dev], runtime: false},
      {:inch_ex, "~> 2.0.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:bypass, "~> 2.1.0", only: :test}
    ]
  end

  defp description() do
    """
    Library for KeyCDN API
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Karlo Šmid"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/karlosmid/exkeycdn"}
    ]
  end
end
