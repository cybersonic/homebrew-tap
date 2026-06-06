class Lucli < Formula
  desc "CLI for Lucee CFML (LuCLI)"
  homepage "https://github.com/cybersonic/LuCLI"
  version "0.1.266"

  on_macos do
    url "https://github.com/cybersonic/LuCLI/releases/download/v0.1.266/lucli-0.1.266-macos"
    sha256 "3c1b41555cfe59ccd8fbd419d01aa7d6b0a96f7707fa421795ac231855048686"
  end

  on_linux do
    url "https://github.com/cybersonic/LuCLI/releases/download/v0.1.266/lucli-0.1.266-linux"
    sha256 "d132f5d5dbd7603e675f373a8c491bf758d65eec4e3f3193cad6a0350ac2f30f"
  end

  # If these binaries require Java on PATH, you can add:
  # depends_on "openjdk"

  def install
    downloaded = if OS.mac?
      "lucli-#{version}-macos"
    else
      "lucli-#{version}-linux"
    end

    # Install the downloaded binary under libexec and expose a wrapper in bin.
    libexec.install downloaded => "lucli"
    bin.write_exec_script libexec/"lucli"
  end

  test do
    system "#{bin}/lucli", "--version"
  end
end