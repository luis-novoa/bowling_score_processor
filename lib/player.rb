class Player
  attr_accessor :formatted_rounds, :scores
  attr_reader :rounds
  def initialize(name, rounds)
    abort "\"#{name}\" doesn't have the minimum number of rounds." if rounds.size < 12
    abort "\"#{name}\" has more rounds than the limit." if rounds.size > 21

    @name = name
    @rounds = rounds
  end

  # def self.create_players_from_hash(hash, target_object)
end