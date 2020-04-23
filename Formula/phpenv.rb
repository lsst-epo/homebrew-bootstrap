class Phpenv < Formula
  desc "PHP version manager"
  homepage "https://github.com/castiron/phpenv#readme"
#  url "https://github.com/castiron/phpenv/archive/v1.0.0.tar.gz"
#  sha256 "baea56d63e5fa60ea5658360dc05665ff770184ce826191ce268ca73feaf3e80"
#  head "https://github.com/castiron/phpenv.git"
  url "https://github.com/phpenv/phpenv", :using => :git, :revision => "9b7e4e1c0083c46be69f4c6d063f78c18654aad1"
  head "https://github.com/phpenv/phpenv.git"
  version "1.1"

  depends_on "php-build" => :recommended

  def install
    prefix.install ["bin", "completions", "libexec"]
  end

  test do
    shell_output("eval \"$(#{bin}/phpenv init -)\" && phpenv versions")
  end
end
