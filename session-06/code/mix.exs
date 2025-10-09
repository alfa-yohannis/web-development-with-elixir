# mix.exs
defmodule AvatarGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :avatar_generator,
      version: "0.1.0",
      elixir: "~> 1.17",          # works with 1.18 toolchains
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {AvatarGenerator, [] }
    ]
  end

  defp deps do
    [
      {:egd, github: "erlang/egd", manager: :rebar3}
    ]
  end
end


# defmodule Identicon.Mixfile do
#   use Mix.Project

#   def project do
#     [app: :identicon,
#      version: "0.1.0",
#      elixir: "~> 1.3",
#      build_embedded: Mix.env == :prod,
#      start_permanent: Mix.env == :prod,
#      deps: deps()]
#   end

#   # Configuration for the OTP application
#   #
#   # Type "mix help compile.app" for more information
#   def application do
#     [applications: [:logger]]
#   end

#   # Dependencies can be Hex packages:
#   #
#   #   {:mydep, "~> 0.3.0"}
#   #
#   # Or git/path repositories:
#   #
#   #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
#   #
#   # Type "mix help deps" for more examples and options
#   # defp deps do
#   #   [
#   #     {:egd, github: "erlang/egd", manager: :rebar3}
#   #   ]
#   # end

#   defp deps do
#     [
#       {:egd, github: "erlang/egd", manager: :rebar3}
#     ]
# end
# end
