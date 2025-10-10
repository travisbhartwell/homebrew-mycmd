class Myproject < Formula
  desc "Project Task Runner using MyCmd"
  homepage "https://github.com/travisbhartwell/myproject"
  url "https://github.com/travisbhartwell/myproject/releases/download/v0.02/myproject-0.02.tar.gz"
  sha256 "60e5dca48495d0e0d908b4e67661f48190141dc66f4c5df6cf38f2bd1c15dbbd"
  license "MIT"

  depends_on "git"
  depends_on "mycmd"

  on_macos do
    depends_on "coreutils"
    depends_on "grep"
    depends_on "findutils"
  end

  def install
    prefix.install "mycmd"
  end

  def caveats
    <<~EOS
      To make MyProject available to MyCmd, you need to set MYCMD_SEARCH_PATH in your shell to the following:

      MYCMD_SEARCH_PATH=#{prefix}/mycmd
    EOS
  end

  test do
    ENV["MYCMD_SEARCH_PATH"] = "#{prefix}/mycmd"
    system Formula["mycmd"].bin/"mycmd", "myproject", "--version"
  end
end
