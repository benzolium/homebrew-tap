class Raskraska < Formula
  desc "Convert photos into numbered coloring pages"
  homepage "https://github.com/benzolium/raskraska"
  url "https://github.com/benzolium/raskraska/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7570e6f95b86d8b66ae68d7856de68e36febf93e14c8609f11b29bc8f9a89b1b"
  license "MIT"
  head "https://github.com/benzolium/raskraska.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/raskraska --help")
  end
end
