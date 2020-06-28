class Game
  attr_accessor :players_rounds
  def initialize(file)
    abort 'File input is empty.' if file == ''

    @players_rounds = file.split("\n")
    @player_list = []
  end

  def process_rounds
    players_hash = Hash.new
    players_rounds.each do |e|
      splitted = e.split(' ')
      abort "\"#{e}\" can't be processed." unless splitted.size == 2
      abort "Invalid score on \"#{e}\"." unless splitted[1].match?(/(^[0-9]$)|(^10$)|(^F$)/)
    end
  end
end