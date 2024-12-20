class Oracles < Formula
  desc "Oracles"
  homepage "https://github.com/butaneprotocol/oracles"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.17.0/oracles-aarch64-apple-darwin.tar.xz"
      sha256 "2a944d551053529349eb98044e8170b9175d0ad3f790fd625a207bce0061b526"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.17.0/oracles-x86_64-apple-darwin.tar.xz"
      sha256 "116e2e0afff00a830a2320a49fa21bbe82f634255504a59c71ae70254890f844"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.17.0/oracles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "60606060566e1201cfafeebc595d1392e6cf8b3a591eecac96c3aeb921175204"
    end
    if Hardware::CPU.intel?
      url "https://github.com/butaneprotocol/oracles/releases/download/v0.17.0/oracles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b51c0b0a031df92e14618b054e74bc89ede0f11f47970bb9bb86dd1c3ca8e95d"
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
