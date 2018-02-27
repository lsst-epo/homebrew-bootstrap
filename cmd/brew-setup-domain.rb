#!/usr/bin/env ruby
# Does a thing
require "erb"
require "pathname"

tap_root = File.join(ENV["HOMEBREW_LIBRARY"], "Taps", "castiron", "homebrew-bootstrap")
template_dir = File.join(tap_root, "templates")
puts template_dir