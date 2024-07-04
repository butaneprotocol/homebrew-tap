class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.7.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.12/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "b5c8fbac3f7bdff6525156dba432a4bc3c4be0933e59552b3372f8c64b7e532f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.12/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "d20a69c49f7a26927be263ec66d3682aa056dfa7d7a1e871f0d99fd350f72144"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.12/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ebb06efaa06ac98aa732f872a75af95da25a8e9cda6e68894b95c4b5241d5ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.12/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eaa99b1129e6bb1f9de592d8a7cda325d5a3c51ed5a833d7ad79a8887399cccd"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "keygen", "oracles"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "keygen", "oracles"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "keygen", "oracles"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "keygen", "oracles"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
