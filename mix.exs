defmodule NervesSystemF3RP70.MixProject do
  use Mix.Project

  @github_organization "pojiro"
  @app :nerves_system_f3rp70
  @source_url "https://github.com/#{@github_organization}/#{@app}"
  @version "0.4.2"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.6",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: [
        loadconfig: [&bootstrap/1],
        docs: ["docs", &copy_images/1],
        test_version_match: [&test_version_match/1]
      ],
      docs: docs(),
      preferred_cli_env: %{
        docs: :docs,
        "hex.build": :docs,
        "hex.publish": :docs
      }
    ]
  end

  def application do
    []
  end

  defp bootstrap(args) do
    set_target()
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  defp nerves_package do
    [
      type: :system,
      artifact_sites: [
        {:github_releases, "#{@github_organization}/#{@app}"}
      ],
      build_runner_opts: build_runner_opts(),
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      # The :env key is an optional experimental feature for adding environment
      # variables to the crosscompile environment. These are intended for
      # llvm-based tooling that may need more precise processor information.
      env: [
        {"TARGET_ARCH", "arm"},
        {"TARGET_CPU", "cortex_a9"},
        {"TARGET_OS", "linux"},
        {"TARGET_ABI", "gnueabihf"}
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 1.6.0 or ~> 1.7.4 or ~> 1.8.0", runtime: false},
      {:nerves_system_br, "1.20.3", runtime: false},
      {:nerves_toolchain_armv7_nerves_linux_gnueabihf, "~> 1.4.2", runtime: false},
      {:nerves_system_linter, "~> 0.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :docs, runtime: false}
    ]
  end

  defp description do
    """
    Nerves System - F3RP70
    """
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp package do
    [
      files: package_files(),
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp package_files do
    [
      "CHANGELOG.md",
      "Config.in",
      "LICENSE",
      "README.md",
      "VERSION",
      "fwup-revert.conf",
      "fwup.conf",
      "fwup_include",
      "kernel-patches",
      "linux-4.14.164-rt73-ert3xlnx.defconfig",
      "mix.exs",
      "nerves_defconfig",
      "post-build.sh",
      "post-createfs.sh",
      "rootfs_overlay",
      "uEnv.txt"
    ]
  end

  # Copy the images referenced by docs, since ex_doc doesn't do this.
  defp copy_images(_) do
    File.cp_r("assets", "doc/assets")
  end

  defp build_runner_opts() do
    case System.get_env("BR2_PRIMARY_SITE") do
      nil -> []
      primary_site -> [make_args: ["BR2_PRIMARY_SITE=#{primary_site}"]]
    end
  end

  defp set_target() do
    if function_exported?(Mix, :target, 1) do
      apply(Mix, :target, [:target])
    else
      System.put_env("MIX_TARGET", "target")
    end
  end

  defp test_version_match(_args) do
    version = Path.join(__DIR__, "VERSION") |> File.read!() |> String.trim()

    if @version != version do
      IO.puts(
        "The version(#{@version}) of mix.exs does not match the version(#{version}) of VERSION."
      )

      exit({:shutdown, 1})
    end
  end
end
