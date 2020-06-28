class Player
  attr_accessor :formatted_rounds, :scores
  attr_reader :name, :rounds
  def initialize(name, rounds)
    abort "\"#{name}\" doesn't have the minimum number of rounds." if rounds.size < 12
    abort "\"#{name}\" has more rounds than the limit." if rounds.size > 21

    @name = name
    @rounds = rounds
  end

  def self.create_players_from_hash(hash)
    output = []
    hash.each do |k, v|
      output.push(Player.new(k, v))
    end
    output
  end

  def generate_personal_score
    self.scores = []
    self.formatted_rounds = []
    only_numbers = rounds.map do |e|
      if e == 'F'
        e = 0
      else
        e.to_i
      end
    end
    round_score = 0
    i = 0
    loop do
      if round_score > 300
        abort "\"#{name}\" scored more than 300 points!"
      elsif i == rounds.size - 3
        round_score += only_numbers[i] + only_numbers[i+1] + only_numbers[i+2]
        self.scores.push(round_score)
        format_score([rounds[i], rounds[i+1], rounds[i+2]])
        break
      elsif only_numbers[i] == 10
        round_score += only_numbers[i] + only_numbers[i+1] + only_numbers[i+2]
        self.scores.push(round_score)
        format_score('X')
        i += 1
      elsif only_numbers[i] + only_numbers[i+1] == 10
        round_score += only_numbers[i] + only_numbers[i+1] + only_numbers[i+2]
        self.scores.push(round_score)
        format_score([rounds[i], rounds[i+1]], true)
        i += 2
      elsif only_numbers[i] + only_numbers[i+1] < 10
        round_score += only_numbers[i] + only_numbers[i+1]
        self.scores.push(round_score)
        format_score([rounds[i], rounds[i+1]])
        i += 2
      else
        abort "\"#{name}\" scored more than 10 points in one round!"
      end
    end
  end

  private
  def format_score(value, spare = false)
    return self.formatted_rounds.push([nil, 'X']) if value == 'X'
    return self.formatted_rounds.push([value[0], '/']) if spare

    if value.size == 3
      value.map! do |e|
        e = 'X' if e == '10'
        e
      end
    end
    self.formatted_rounds.push(value)
  end
end