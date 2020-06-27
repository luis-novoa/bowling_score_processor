class Game
  attr_accessor :file
  def initialize(file)
    abort 'File input is empty.' if file == ''

    @file = file.split("\n")
    @player_list = []
    @player_names = []
  end

  def process_rounds
    file.map! do |e|
      splitted = e.split(' ')
      abort "\"#{e}\" can't be processed." unless splitted.size == 2

      e = splitted
    end
  end
end