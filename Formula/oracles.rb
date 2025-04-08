class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.24.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.2/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "cf6285f7bd5d254c9f075830d23adcce424b071946b2e6dcedb866de8765989c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.2/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "810560ad8f5657a01f28f4d0501bf4ae15d2305d048530ed13b55be3e119da0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.2/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b1da2de7e53c527c20a8cb07575cc4247f97dd53c0bbb02c27e6d64e28e75836"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.2/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3dfb329a3e9bb0bc7240328096cc1b6e1911b7c051634474508fb7750ac15b3c"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "keygen", "oracles" if OS.mac? && Hardware::CPU.arm?
    bin.install "keygen", "oracles" if OS.mac? && Hardware::CPU.intel?
    bin.install "keygen", "oracles" if OS.linux? && Hardware::CPU.arm?
    bin.install "keygen", "oracles" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
