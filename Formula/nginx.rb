loadedCustomConfig = false
begin
  require '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/nginx.rb'
  loadedCustomConfig = true
rescue
  begin
    print "require failed! trying m1 folder"
    require '/opt/homebrew/Library/Taps/castiron/homebrew-core/Formula/nginx.rb'
    print "success!"
    loadedCustomConfig = true
  rescue
    print "alternative m1 require folder failedf"

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

if loadedCustomConfig == true
  Nginx.prepend CustomNginx
end
