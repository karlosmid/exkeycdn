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
      {:ex_doc, "~> 0.23.0", only: :dev}
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
