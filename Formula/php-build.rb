class PhpBuild < Formula
  desc "Install various PHP versions and implementations"
  homepage "https://github.com/php-build/php-build"
  # url "https://github.com/php-build/php-build/archive/v0.10.0.tar.gz"
  url "https://github.com/php-build/php-build", :using => :git, :revision => "b24ef12a1e42866a3473625f9c6e937addd53af1"
  # sha256 "9f3f842608ee7cb3a6a9fcf592a469151fc1e73068d1c2bd6dbd15cac379857c"
  head "https://github.com/php-build/php-build.git"

  bottle :unneeded

  depends_on "autoconf" => :recommended
  depends_on "pkg-config" => :recommended
  depends_on "openssl" => :recommended
  depends_on "re2c" => :recommended
  depends_on "bison" => :recommended
  depends_on "libxml2" => :recommended
  depends_on "icu4c" => :recommended

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