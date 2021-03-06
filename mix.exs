defmodule UAInspector.Mixfile do
  use Mix.Project

  @url_github "https://github.com/elixytics/ua_inspector"

  def project do
    [ app:           :ua_inspector,
      name:          "UAInspector",
      version:       "0.6.0-dev",
      elixir:        "~> 1.0",
      deps:          deps(Mix.env),
      docs:          docs,
      test_coverage: [ tool: ExCoveralls ]]
  end

  def application do
    [ applications: [ :yamerl ],
      mod:          { UAInspector, [] } ]
  end

  def deps(:docs) do
    deps(:prod) ++
      [ { :earmark, "~> 0.1" },
        { :ex_doc,  "~> 0.7" } ]
  end

  def deps(:test) do
    deps(:prod) ++
      [ { :dialyze,     "~> 0.1" },
        { :excoveralls, "~> 0.3" } ]
  end

  def deps(_) do
    [ { :poolboy, "~> 1.0" },
      { :yamerl,  github: "yakaz/yamerl" } ]
  end

  def docs do
    [ main:       "README",
      readme:     "README.md",
      source_ref: "master",
      source_url: @url_github ]
  end
end
