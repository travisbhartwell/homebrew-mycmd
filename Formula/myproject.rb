class Myproject < Formula
  desc "Project Task Runner using MyCmd"
  homepage "https://github.com/travisbhartwell/myproject"
  url "https://github.com/travisbhartwell/myproject/releases/download/v0.03/myproject-0.03.tar.gz"
  sha256 "9dd95b6efae42fd93f88bd328838547c38331444be4add23330931566e43b98e"
  license "MIT"

  depends_on "git"
  depends_on "mycmd"

  on_macos do
    depends_on "coreutils"
    depends_on "findutils"
    depends_on "grep"
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
