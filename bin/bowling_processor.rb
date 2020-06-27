#!/usr/bin/ruby

require File.expand_path('../lib/game', __dir__)

file_path = File.expand_path("../input/#{ARGV[0]}", __dir__)
file = File.read(file_path)
processed_list = Game.new(file)