class TextProcessor
  attr_accessor :file, :game
  def initialize(file, game)
    abort 'File input is empty.' if file == ''

    @game = game
    @file = file.split("\n")
  end
end