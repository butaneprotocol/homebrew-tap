class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.22.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.22.3/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "c7f63dc816695d758f6a90b1cc8fc531ea12f88a38656fcc9d5d4b1ba2efbbb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.22.3/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "6a38b568a519b22b2f169d7452ba232751207f704e52734f0021fb3ee15f935f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.22.3/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b2278cab3a02ce3d82b67ac6b74a257f84d68218d52c6b6dab8acc4db422871"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.22.3/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82141b9a56dfe762840bb0f9cc6b6f5be8b6451d7cb48889fdbc7390b9d9c35b"
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
