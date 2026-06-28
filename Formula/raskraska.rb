class Raskraska < Formula
  desc "Convert photos into numbered coloring pages"
  homepage "https://github.com/benzolium/raskraska"
  url "https://github.com/benzolium/raskraska/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "48e13a99b2f8d4cc3efd5c403026ee60fc9e2b1af5ea7f202a05654b220abc0a"
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
