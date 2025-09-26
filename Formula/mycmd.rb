class Mycmd < Formula
  desc "Tool for writing and running commands from a command directory"
  homepage "https://github.com/travisbhartwell/mycmd"
  url "https://github.com/travisbhartwell/mycmd/releases/download/v0.02/mycmd-0.02.tar.gz"
  sha256 "c32249a83d9de65ce405073ac0934ef1fa4349f5f7bba6c1f08bbeeb099e0f9a"
  license "MIT"

  depends_on "fzf"

  on_macos do
    depends_on "bash"
    depends_on "coreutils"

    depends_on "findutils" => :optional
    depends_on "gnu-sed" => :optional
    depends_on "grep" => :optional
  end

  def install
    bin.install "bin/mycmd"
    inreplace bin/"mycmd",
      "#!/usr/bin/env bash",
      "#!/usr/bin/env MYCMD_SYSTEM_PATH=\"#{prefix}/mycmd\" " \
      "MYCMD_VENDOR_PATH=\"#{prefix}/vendor\" " \
      "#{HOMEBREW_PREFIX}/bin/bash"
    inreplace bin/"mycmd",
      '_MYCMD_LAUNCHER_SELF_FILE="${BASH_SOURCE[0]}"',
      "_MYCMD_LAUNCHER_SELF_FILE=\"#{bin}/mycmd\""
    inreplace bin/"mycmd",
      'MYCMD_BIN_DIR=$(cd "$(dirname "${_MYCMD_LAUNCHER_SELF_FILE}")" &>/dev/null && pwd -P)',
      "MYCMD_BIN_DIR=#{bin}"

    prefix.install "vendor"
    prefix.install "mycmd"
  end

  test do
    system "#{bin}/mycmd", "--version"
  end
end
