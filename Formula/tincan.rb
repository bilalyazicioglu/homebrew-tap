class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://github.com/bilalyazicioglu/tincan-cli"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.2.3/tincan-aarch64-apple-darwin.tar.gz"
      sha256 "e03317145ec59bdfa6a3b983ad18279a3ddebe1f34478e08503f1a687d7af417"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.2.3/tincan-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a89d9b0a6ea34c0ec60d33c9685730094be0365fe9511100daf6f04091524a67"
    end
  end

  def install
    bin.install "tincan"
    generate_completions_from_executable(bin/"tincan", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tincan --version")
    assert_match "completions", shell_output("#{bin}/tincan --help")
  end
end
