class Markspresso < Formula
  desc "CLI for Markspresso static site generation"
  homepage "https://github.com/cybersonic/markspresso"
  version "1.0.3"
  url "https://github.com/cybersonic/markspresso/releases/download/v1.0.3/markspresso"
  sha256 "af7099ca77b3e1c5ecbeaaa2c6d76eb3107bd6d336817e40332b1131336d15cb"
  depends_on "openjdk"

  def install
    libexec.install "markspresso"
    chmod 0755, libexec/"markspresso"
    bin.write_env_script libexec/"markspresso", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  test do
    system "#{bin}/markspresso", "--version"
  end
end
