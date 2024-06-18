class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.7.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.6/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "bde5d75a76e6450b3f10462fe40dc3a8bbba6a01ed0d51380e50cb6c3f7cc114"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.6/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "53aec5e0581729ee20b771e3b225ed440cd5fb82f625b33f9c3e9ba8b7fa26c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.6/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1adb0a110c336853eb5e26dfa50b3d1264a2358f2fb5b4b53a6df89e08e8631"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.7.6/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21bc0ad4a1a526191100f958e67eb72a40c55d3c9fd0adaca8659ad8e030cd75"
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
