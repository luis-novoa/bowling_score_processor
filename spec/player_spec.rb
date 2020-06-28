# frozen_string_literal: true

require File.expand_path('../lib/player', __dir__)

RSpec.describe Player do
  context "#new" do
    it "detects if player has few rounds" do
      array = ['1']
      expect{ Player.new('John', array) }.to raise_error(SystemExit).and output("\"John\" doesn't have the minimum number of rounds.\n").to_stderr
    end

    it "detects if player has too many rounds" do
      array = Array.new(22, '1')
      expect{ Player.new('John', array) }.to raise_error(SystemExit).and output("\"John\" has more rounds than the limit.\n").to_stderr
    end
  end
  
  context "#create_players_from_hash" do
    let(:player_hash) { {'Joe' => Array.new(12, '10'), 'Marcus' => Array.new(21, 'F')} }
    it "automates creation of players from hash" do
      destiny_array = Player.create_players_from_hash(player_hash)
      expect(destiny_array[0].name).to eq('Joe').or eq('Marcus')
    end
  end
end