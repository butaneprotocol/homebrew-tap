class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.10.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.10.4/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "c9a7f0243de9830e6fc643577e8a88ea4416405771193410415e5546ac4c9ba0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.10.4/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "f6a3d84f654e95ca8f0694e0d9aedf18182beb8b155e0f1b56c177512059487c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.10.4/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "42a3a4b0fe706e7b1bf1ea4f23872fcff657f355ad3ffd9a1dafd41054ff65ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.10.4/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f6b6594b18da7aa462b5930b17c2e9ce21f83ba59128ddbbef31d3903bf869c"
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
