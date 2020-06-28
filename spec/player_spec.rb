require File.expand_path('../lib/player', __dir__)

RSpec.describe Player do
  context '#new' do
    it 'detects if player has few rounds' do
      array = ['1']
      expect do
        Player.new('John', array)
      end.to raise_error(SystemExit).and output("\"John\" doesn't have the minimum number of rounds.\n").to_stderr
    end

    it 'detects if player has too many rounds' do
      array = Array.new(22, '1')
      expect do
        Player.new('John', array)
      end.to raise_error(SystemExit).and output("\"John\" has more rounds than the limit.\n").to_stderr
    end
  end

  context '#create_players_from_hash' do
    let(:player_hash) { { 'Joe' => Array.new(12, '10'), 'Marcus' => Array.new(21, 'F') } }
    it 'automates creation of players from hash' do
      destiny_array = Player.create_players_from_hash(player_hash)
      expect(destiny_array[0].name).to eq('Joe').or eq('Marcus')
    end
  end

  context '#generate_personal_score' do
    it 'calculates strikes correctly' do
      joe = Player.new('Joe', Array.new(12, '10'))
      joe.generate_personal_score
      expect(joe.scores).to eq([30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
    end

    it 'generates strike symbols' do
      joe = Player.new('Joe', Array.new(12, '10'))
      joe.generate_personal_score
      expect(joe.formatted_rounds).to eq(Array.new(9, [' ', 'X']) << %w[X X X])
    end

    it 'calculates spares correctly' do
      array = [1, 9] * 9 + [1, 0, 0]
      joe = Player.new('Joe', array)
      joe.generate_personal_score
      expect(joe.scores).to eq([11, 22, 33, 44, 55, 66, 77, 88, 99, 100])
    end

    it 'generates spares symbols' do
      array = [1, 9] * 9 + [1, 0, 0]
      joe = Player.new('Joe', array)
      joe.generate_personal_score
      expect(joe.formatted_rounds).to eq([[1, '/']] * 9 + [[1, 0, 0]])
    end

    it 'calculates fouls correctly' do
      joe = Player.new('Joe', Array.new(21, 'F'))
      joe.generate_personal_score
      expect(joe.scores).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    end

    it 'includes foul symbol in formatted_rounds' do
      joe = Player.new('Joe', Array.new(21, 'F'))
      joe.generate_personal_score
      expect(joe.formatted_rounds).to eq([%w[F F]] * 9 + [['F'] * 3])
    end

    it 'detects if the sum of two rounds is bigger than 10' do
      joe = Player.new('Joe', Array.new(21, '6'))
      expect do
        joe.generate_personal_score
      end.to raise_error(SystemExit).and output("\"Joe\" scored more than 10 points in one round!\n").to_stderr
    end

    it 'detects if the score is too high' do
      joe = Player.new('Joe', Array.new(21, '10'))
      expect do
        joe.generate_personal_score
      end.to raise_error(SystemExit).and output("\"Joe\" scored more than 300 points!\n").to_stderr
    end
  end
end
