class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.24.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.1/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "6721c6671ed036a4808e988aefd5c68ba34755de1288135388b6be7c6ef8ada3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.1/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "75c274c8b6e7145ae10a7d25bf827848b03492a7bcfb5a393c315deab88a5f1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.1/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d1239fe24c2f9ed467bfc863c94085ebd9a192b1d0ade540b1324725a1ce2bc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.1/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf470905dcf6cfe74b5dd09959f61f5fac3d02ace1f438a3cdeddd016a5c5cbb"
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
