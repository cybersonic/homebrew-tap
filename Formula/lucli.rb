class Lucli < Formula
  desc "CLI for Lucee CFML (LuCLI)"
  homepage "https://github.com/cybersonic/LuCLI"
  license "MIT"

  LUCLI_VERSION = "0.3.3"

  if OS.mac?
    url "https://github.com/cybersonic/LuCLI/releases/download/v#{LUCLI_VERSION}/lucli-#{LUCLI_VERSION}-macos"
    sha256 "6abf3fa8637ad66ef11592a91649a91b27c620cbaa7aaeb434725e1c15c6b676"
  elsif OS.linux?
    url "https://github.com/cybersonic/LuCLI/releases/download/v#{LUCLI_VERSION}/lucli-#{LUCLI_VERSION}-linux"
    sha256 "3c74ca291b8df26cc4c1e77c8162755b604acc03f6e0fa172602826d35a18126"
  end

  depends_on "openjdk@21"

  def install
    binary = Dir["*"].first
    libexec.install binary => "lucli"
    chmod 0755, libexec/"lucli"

    (bin/"lucli").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="#{Formula["openjdk@21"].opt_libexec}/openjdk.jdk/Contents/Home"
      exec "#{HOMEBREW_PREFIX}/opt/lucli/libexec/lucli" "$@"
    EOS
    chmod 0755, bin/"lucli"
  end

  def caveats
    <<~EOS
      Java 21 is required and has been installed as a dependency.
    EOS
  end

  test do
    assert_predicate bin/"lucli", :executable?
    assert_predicate libexec/"lucli", :executable?
  end
end
