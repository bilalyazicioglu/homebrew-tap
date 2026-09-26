class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://github.com/bilalyazicioglu/tincan-cli"
  version "0.3.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.2/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "bec5479ac78e57b75de76cb82e25653d6d3438105277e6d3603b1db3dbd009ef"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.2/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "5554c92addf6525353dbd5074da5f5b289cfeefb046d2114f676639eec385b7e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.2/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0b86620454e565f4a7bcf4eb8670455d7eccaaf0fddead2a96d709bad0a0d5ba"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.2/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "a81233885d8bae9d5a8c588ff803d4fec4fb689b301f651c6297dfdc4486542c"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.3.2.tar.gz"
    sha256 "a7fb669570e4f79ed110fea5a036b290013845720f9d586ae4f3c93ad3390921"
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
