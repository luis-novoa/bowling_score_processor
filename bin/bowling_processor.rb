#!/usr/bin/ruby

require File.expand_path('../lib/game', __dir__)
require File.expand_path('../lib/player', __dir__)

def process_bowling_report(file)
  game = Game.new(file)
  game.process_rounds
  game.player_list = Player.create_players_from_hash(game.players_rounds)
  game.player_list.each { |e| e.generate_personal_score }
  game.player_list.sort_by(&:name)
  puts "+----------+----+----+----+----+----+----+----+----+----+------+"
  puts "|Frame     |1   |2   |3   |4   |5   |6   |7   |8   |9   |10    |"
  puts "+----------+----+----+----+----+----+----+----+----+----+------+"
  game.player_list.each do |player|
    puts "|#{player.name.ljust(62)}|"
    puts "+----------+----+----+----+----+----+----+----+----+----+------+"
    print "|Pinfalls  |"
    player.formatted_rounds.each_with_index do |e, i|
      if i == player.formatted_rounds.size - 1
        puts "#{e[0]} #{e[1]} #{e[2]} |"
      else
        print "#{e[0]} #{e[1]} |"
      end
    end
    puts "+----------+----+----+----+----+----+----+----+----+----+------+"
    print "|Score     |"
    player.scores.each_with_index do |e, i|
      if i == player.formatted_rounds.size - 1
        puts "#{e.to_s.ljust(6)}|"
      else
        print "#{e.to_s.ljust(4)}|"
      end
    end
    puts "+----------+----+----+----+----+----+----+----+----+----+------+"
  end
end

if __FILE__ == $0
  file_path = File.expand_path("../input/#{ARGV[0]}", __dir__)
  file = File.read(file_path)
  process_bowling_report(file)
end