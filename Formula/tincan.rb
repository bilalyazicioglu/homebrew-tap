class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://github.com/bilalyazicioglu/tincan-cli"
  version "0.2.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.2.3/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "e03317145ec59bdfa6a3b983ad18279a3ddebe1f34478e08503f1a687d7af417"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.2.3/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a89d9b0a6ea34c0ec60d33c9685730094be0365fe9511100daf6f04091524a67"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.2.3.tar.gz"
    sha256 "72836aa25e377f9b319f97f43f917d2acda1e2ccbbc773a311c52c82a01d6dd1"
  end

  def install
    if File.exist?("tincan")
      bin.install "tincan"
    else
      system "cargo", "install", *std_cargo_args
    end
    generate_completions_from_executable(bin/"tincan", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tincan --version")
    assert_match "completions", shell_output("#{bin}/tincan --help")
  end
end
