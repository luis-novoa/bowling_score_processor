class Player
  attr_accessor :formatted_rounds, :scores
  attr_reader :name, :rounds
  def initialize(name, rounds)
    abort "\"#{name}\" doesn't have the minimum number of rounds." if rounds.size < 12
    abort "\"#{name}\" has more rounds than the limit." if rounds.size > 21

    @name = name
    @rounds = rounds
    @scores = []
    @formatted_rounds = []
  end

  def self.create_players_from_hash(hash)
    output = []
    hash.each do |k, v|
      output.push(Player.new(k, v))
    end
    output
  end

  def generate_personal_score
    only_numbers = rounds.map(&:to_i)
    round_score = 0
    i = 0
    loop do
      round_score += only_numbers[i] + only_numbers[i + 1] + only_numbers[i + 2]
      if round_score > 300
        abort "\"#{name}\" scored more than 300 points!"
      elsif i == rounds.size - 3
        scores.push(round_score)
        format_score([rounds[i], rounds[i + 1], rounds[i + 2]])
        break
      elsif only_numbers[i] == 10
        scores.push(round_score)
        format_score('X')
        i += 1
      else
        round_score = check_round_score(only_numbers[i], only_numbers[i + 1], only_numbers[i + 2], round_score, i)
        i += 2
      end
    end
  end

  private

  def format_score(value, spare = false)
    return formatted_rounds.push([' ', 'X']) if value == 'X'
    return formatted_rounds.push([value[0], '/']) if spare

    if value.size == 3
      value.map! do |e|
        e = 'X' if e == '10'
        e
      end
    end
    formatted_rounds.push(value)
  end

  def check_round_score(score1, score2, score3, total_score, marker)
    case score1 + score2 <=> 10
    when -1
      total_score -= score3
      format_score([rounds[marker], rounds[marker + 1]])
    when 0
      format_score([rounds[marker], rounds[marker + 1]], true)
    else
      abort "\"#{name}\" scored more than 10 points in one round!"
    end
    scores.push(total_score)
    total_score
  end
end
