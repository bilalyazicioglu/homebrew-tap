class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://github.com/bilalyazicioglu/tincan-cli"
  version "0.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.1/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "de0eaefc6f2d3b01f6bc192c47113fa9dbca12f887b4edafee55664abf743028"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.1/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "7ffd5f0e0cea7fdb377743b910ad39b35fba04e592841271eecec8ecfb9b9909"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.1/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d305aafe473e5a333d2a5ca41bffc5acbcb59b559a4264d4e36c0db86a6e02b3"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.1/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "02995c854082c2303bec27017be2a3ff3357fae74f38c3d2c7ff4dd92d018d9a"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.3.1.tar.gz"
    sha256 "5a853fc673db9c2db0c3dd78aa38f834b78e835c176312719ccd219b2bd92740"
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
