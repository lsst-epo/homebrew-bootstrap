#!/usr/bin/env ruby

require "pathname"
require "fileutils"

type = ARGV.shift

if type.to_s.empty?
  abort "Usage: brew install-scripts <type>"
end

tap_root = File.join(ENV["HOMEBREW_LIBRARY"], "Taps", "castiron", "homebrew-bootstrap")
template_dir = File.join(tap_root, "templates", "scripts")
target_dir = "./scripts"

children = Pathname.new(template_dir).children
valid_types = children.select { |c| c.directory? }.collect { |p| p.basename.to_s }

unless valid_types.include? type
	abort "Invalid type. Valid types include: #{valid_types.join(", ")}"
end

source_dir = File.join(template_dir, type)

unless Dir.exists? target_dir
	puts "Creating scripts directory."
	Dir.mkdir target_dir
end

scripts = Pathname.new(source_dir).children.select { |c| c.file? }

accept = "y"
scripts.each do |script|
	script_name = script.basename.to_s
	target = Pathname.new(File.join(target_dir, script_name))
	if File.exists?(target) && accept != "a"
		puts "File exists #{target}. Overwrite? (y, n, a)"
		STDOUT.flush
		accept = gets.chomp
	end
	if accept == "y" || accept == "a"
		puts "Creating script at #{target}"
		FileUtils.cp(script, target)
	end
end
