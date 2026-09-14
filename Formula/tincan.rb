class Tincan < Formula
  desc "Serverless peer-to-peer voice and text chat for your terminal"
  homepage "https://github.com/bilalyazicioglu/tincan-cli"
  version "0.3.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.0/tincan-aarch64-apple-darwin.tar.gz"
    sha256 "883a6414eb4b8562b8875aaeb1e0782b35e8b30f3d5fe1996930c888463c6066"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.0/tincan-x86_64-apple-darwin.tar.gz"
    sha256 "e60d2ff96cca297a4b3b88220e5d67a43a4411d36fc8e3a6e7d8f83d43049102"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.0/tincan-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c939d6e6ab41d4d945444b900758ac369e46b97230a7bc05476822e756c54bfa"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/bilalyazicioglu/tincan-cli/releases/download/v0.3.0/tincan-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "139dbea0b80f44c7242a97bd3c558b7b08c89d03218be3226440ccfc1c57b1b5"
  else
    url "https://github.com/bilalyazicioglu/tincan-cli/archive/refs/tags/v0.3.0.tar.gz"
    sha256 "6964a6fe2186c9af97a2d5102fcac63b58378003f4b79024866b0dcf19b453af"
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
