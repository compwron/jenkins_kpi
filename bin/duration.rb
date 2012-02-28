#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../lib/pipeline')

puts "#{Pipeline.new.duration(ARGV[0])} minutes"
