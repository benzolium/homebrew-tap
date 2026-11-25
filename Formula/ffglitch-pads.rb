class FfglitchPads < Formula
  desc "Local video glitch editor with four playable effect pads"
  homepage "https://github.com/benzolium/ffglitch-pads"
  url "https://github.com/benzolium/ffglitch-pads/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "4a4d4ab161a9515cfac60391d72cec10609b1bd240b26ffdb094d5d07aa151cb"
  license all_of: ["MIT", "GPL-2.0-or-later"]

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on :macos

  # FFglitch is an independently invoked GPL program. Corresponding sources:
  # https://ffglitch.org/pub/src/ffglitch-0.10.2.tar.xz
  resource "ffedit" do
    url "https://ffglitch.org/pub/bin/macos-aarch64/ffglitch-0.10.2-macos-aarch64.zip"
    sha256 "25a5a7d51217919db5a093b211fd8a1e27845284efb0a6f616b8f371f6638eef"
  end

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
    libexec.install bin/"ffglitch-pads"
    resource("ffedit").stage do
      libexec.install "ffedit"
      pkgshare.install "readme.txt" => "FFglitch-README.txt"
    end
    (bin/"ffglitch-pads").write_env_script libexec/"ffglitch-pads",
                                         FFEDIT: libexec/"ffedit",
                                         FFMPEG: Formula["ffmpeg"].opt_bin/"ffmpeg",
                                         FFPROBE: Formula["ffmpeg"].opt_bin/"ffprobe"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ffglitch-pads --help")
    assert_match "ffglitch-0.10.2", shell_output("#{libexec}/ffedit -version")
  end
end
