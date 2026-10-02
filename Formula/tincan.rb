class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://tincan.rs"
  version "0.3.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.3/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "d5267242ea40c55510a4d9e871b552bb73a21ed0f9d2ad0ec246c30221097c38"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.3/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "010e2ac801fd0da354cf956d6871a7be48c7182cec06b672c83909acb9355f43"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.3/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4a51f30ea74c389678cf35ae5b35967d2cf19868eca26e4efc749fedf0fb74f4"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.3/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "36b8b8913bcb55f2f7144c50349e24ef862fd169052c28de4b43cba78489bf3d"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.3.3.tar.gz"
    sha256 "593cd70756c1dde0c34bedb32586dd89e16f1762c0fd8a8afce68075ab663488"
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
