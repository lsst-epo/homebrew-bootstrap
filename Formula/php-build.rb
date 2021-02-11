class PhpBuild < Formula
  desc "Install various PHP versions and implementations"
  homepage "https://github.com/php-build/php-build"
  url "https://github.com/php-build/php-build", :using => :git, :revision => "ac70160961508ca1180f0ba7b90f3c6de9c63576"
  head "https://github.com/php-build/php-build.git"
  version "1.2"
  bottle :unneeded

  depends_on "autoconf" => :recommended
  depends_on "pkg-config" => :recommended
  depends_on "openssl" => :recommended
  depends_on "re2c" => :recommended
  depends_on "bison" => :recommended
  depends_on "libxml2" => :recommended
  depends_on "icu4c" => :recommended
  depends_on "mcrypt" => :recommended

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
    # WTF WHY.
    rm_f "#{bin}/rbenv-install"
    rm_f "#{bin}/rbenv-uninstall"
    rm_f "#{bin}/rbenv-update"
  end

  test do
    assert_match "2.0.0", shell_output("#{bin}/php-build --definitions")
  end
end
