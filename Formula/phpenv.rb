class Phpenv < Formula
  desc "PHP version manager"
  homepage "https://github.com/castiron/phpenv#readme"
  url "https://github.com/castiron/phpenv/archive/v1.0.0.tar.gz"
  sha256 "baea56d63e5fa60ea5658360dc05665ff770184ce826191ce268ca73feaf3e80"
  head "https://github.com/castiron/phpenv.git"

  # bottle do
  #   cellar :any
  #   sha256 "ffafe9cbf0f10545e0c7db8a5ea0ed3056226441391911d2992b2373de94afe3" => :high_sierra
  #   sha256 "a99c9b4ba77938ce03b8e06e0e4d7670c611214b07b78d2b5e1bc9a7571f9186" => :sierra
  #   sha256 "9d1a7da30fb133b43b243e562167ffdde6c125f054c3fde7a866a0b15173f269" => :el_capitan
  #   sha256 "e3e0e0b32a1bb337178d915a91ac7f552153cbf351973f9ef1692d9644824f61" => :yosemite
  # end

  depends_on "php-build" => :recommended

  def install
    prefix.install ["bin", "completions", "libexec"]
  end

  test do
    shell_output("eval \"$(#{bin}/phpenv init -)\" && phpenv versions")
  end
end