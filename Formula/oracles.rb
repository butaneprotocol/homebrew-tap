class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.24.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.3/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "6d316a85453e401b1933fdec7d8109f4f946730e8c31449b1dfd1c6fcced4826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.3/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "92e3cc73ce2cb3c7b13b9281d1423bffbb6f26eeb5e9921e531455e93c85ec9f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.3/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7304b5b28983cbb1c290fc35094bd6835c2a01e1b43d6c7dde84c84ced78390"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.24.3/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9b144f829c28f74d1fac4aea2230a5e8f57e13810fdaf5563c129c60e1247b42"
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
