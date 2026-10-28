class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://tincan.rs"
  version "0.4.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.4.0/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "4b598f341e0c0e73b5b7a02a4df06f5a4971ec39f21ad460153b1a3000436895"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.4.0/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "7e55e7798459f4a51bb53a44a50b1f9229a6a847657568ee6a71ae37878eda11"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.4.0/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f0c94b31e2615986d71f17140381a5ec558610dfb9d0605b85dc9c7670e9edd8"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.4.0/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "c6f778f2f80feeb775edaf4b45b2d4a8f40a9a956e2093a4cf203086fdaea760"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.4.0.tar.gz"
    sha256 "d7f548770114ced57d20917da7a147b73139013a4bc6e77c3b95f7a4b40ad550"
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
