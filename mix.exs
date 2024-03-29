defmodule RemoteJobs.MixProject do
  use Mix.Project

  def project do
    [
      app: :remote_jobs,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {RemoteJobs.Application, []},
      extra_applications: [:logger, :runtime_tools, :bamboo]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:credo, "~> 1.1.3", only: [:dev, :test], runtime: false},
      {:bamboo, "~> 1.3"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.2.0"},
      {:conekta, github: "r-icarus/conekta-elixir"},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:logger_file_backend, "~> 0.0.11"},
      {:excoveralls, "~> 0.11.2", only: :test},
      {:quixir, "~> 0.9", only: :test},
      {:rop, "~> 0.5"},
      {:comeonin, "~> 5.1"},
      {:argon2_elixir, "~> 2.0"},
      {:guardian, "~> 1.2"},
      {:scaffolding, git: "git://github.com/carlogilmar/scaffolding.git", only: [:dev]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
