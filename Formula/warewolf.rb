class Warewolf < Formula
  desc "Install warewolf"
  version '1.0'
  homepage "https://github.com/castiron/warewolf"
  url "git@github.com:castiron/warewolf.git", :using => :git, :revision => "4ae91e8a0f9f6a14eab56bc563acff45074bcc7c"
  head "git@github.com:castiron/warewolf.git"

  bottle :unneeded

  depends_on "rsync" => :recommended

  def install
    system "gem", "install", "--source", source, "warewolf", "--install-dir", prefix
  end

  test do

  end

  private

  def source
    'http://gems.cichq.com:9292'
  end
end
