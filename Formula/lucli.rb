class Lucli < Formula
  desc "CLI for Lucee CFML (LuCLI)"
  homepage "https://github.com/cybersonic/LuCLI"
  version "0.3.17"
  head "https://github.com/cybersonic/LuCLI.git", branch: "main"

  on_macos do
    url "https://github.com/cybersonic/LuCLI/releases/download/v0.3.17/lucli-0.3.17-macos"
    sha256 "cf97659bec46ec30ec41329a9d25d75d3a84add584541cd918683389f5823403"
  end

  on_linux do
    url "https://github.com/cybersonic/LuCLI/releases/download/v0.3.17/lucli-0.3.17-linux"
    sha256 "1e027d932b06db2d381f7f67cc6cac45b0e1004f8a857959f7f8574a50d4aac4"
  end

  depends_on "openjdk"
  on_head do
    depends_on "maven" => :build
  end

  def install
    if build.head?
      ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix
      system "mvn", "clean", "package", "-Pbinary", "-DskipTests"
      libexec.install "target/lucli"
    else
      downloaded = if OS.mac?
        "lucli-#{version}-macos"
      else
        "lucli-#{version}-linux"
      end

      # Install the downloaded binary under libexec and expose a wrapper in bin.
      libexec.install downloaded => "lucli"
    end
    chmod 0755, libexec/"lucli"
    bin.write_exec_script libexec/"lucli"
  end

  test do
    system "#{bin}/lucli", "--version"
  end
end