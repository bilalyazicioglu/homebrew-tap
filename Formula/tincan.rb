class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://tincan.rs"
  version "0.3.4"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.4/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "15e7ebb044602c5d45c4d4c85ae6282163bf4cb0360c97836013922d2d7029e1"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.4/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "2f476765ee03fcadcb0697e6b5396b23fa24efcf3765e06672aeba5ad064deca"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.4/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "36d8744f8b454e11a98240a7148c4029e9414044fc8f1ff64936d8f685f7b368"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.4/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "e4dd52a3dfb90d01ea4d5ebbe540314407496cee473ee9f714ffb8ba0cfd2e50"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.3.4.tar.gz"
    sha256 "5398da1a3bf20e21d90089c67c9bd1385173b0bd8943f911fd1b9163d622729b"
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
