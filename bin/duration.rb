#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../lib/pipeline')

puts "#{Pipeline.new.duration("http://localhost:8080/job/job1.in.pipeline/")} minutes"
