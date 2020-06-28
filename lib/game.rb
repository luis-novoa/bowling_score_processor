class Game
  attr_accessor :players_rounds, :player_list
  def initialize(file)
    abort 'File input is empty.' if file == ''

    @players_rounds = file.split("\n")
  end

  def process_rounds
    players_hash = Hash.new
    players_rounds.each do |e|
      splitted = e.split(' ')
      abort "\"#{e}\" can't be processed." unless splitted.size == 2
      abort "Invalid score on \"#{e}\"." unless splitted[1].match?(/(^[0-9]$)|(^10$)|(^F$)/)

      if players_hash[splitted[0]].nil?
        players_hash[splitted[0]] = [splitted[1]]
      else
        players_hash[splitted[0]].push(splitted[1])
      end
    end
    self.players_rounds = players_hash
  end
end