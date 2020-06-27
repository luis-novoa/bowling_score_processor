class Game
  attr_accessor :file
  def initialize(file)
    abort 'File input is empty.' if file == ''

    @file = file.split("\n")
    @player_list = []
    @player_names = []
  end
end