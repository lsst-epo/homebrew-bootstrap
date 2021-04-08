# For m1 macbooks:
if `uname -m`.strip == "arm64"
  puts 'M1 Macbook detected'
  require '/opt/homebrew/Library/Taps/lsst-epo/homebrew-bootstrap/Formula/nginx.rb'
else # for intel macbooks:
  puts 'Intel Macbook detected'
  require '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/nginx.rb'
end

module CustomNginx

  # Display a message after install or update
  def caveats
  	<<~EOS

      <<<< IMPORTANT >>>>

      Nginx has been updated or installed.

      You will need to make sure nginx is configured to run as root regardless
      of who starts it (e.g. when you start it as your unpriveleged user using brew services).
      To ensure that, please run:

      brew ensure-nginx-executable

      <<<< /IMPORTANT >>>>
    EOS
  end

  # Can't seem to run `sudo` inside the brew runtime environment -- it appears to be disabled through some trickery
  #  so we're going with the "caveats" above for now.
  # def post_install
  # 	update_bin_perms!
  # end

  # def update_bin_perms!
  # 	binfile = bin/"nginx"

  # 	system "sudo chown root: #{binfile}"

  # 	system "sudo chmod u+s #{binfile}"
  # end
end

Nginx.prepend CustomNginx
