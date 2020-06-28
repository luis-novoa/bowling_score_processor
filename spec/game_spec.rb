# frozen_string_literal: true

require File.expand_path('../lib/game', __dir__)

RSpec.describe Game do
  context "#new" do
    it "breaks document into array of lines" do
      txt = "Joe 1\nMarcus 10"
      processor = Game.new(txt)
      expect(processor.players_rounds).to eq(["Joe 1", "Marcus 10"]) 
    end

    it "stops program if file is empty string" do
      expect{ Game.new('') }.to raise_error(SystemExit).and output("File input is empty.\n").to_stderr
    end
  end

  context "#process_rounds" do
    it "detects bad formatted input 1" do
      txt = "Joe1\nMarcus 10"
      processor = Game.new(txt)
      expect{ processor.process_rounds }.to raise_error(SystemExit).and output("\"Joe1\" can't be processed.\n").to_stderr
    end

    it "detects bad formatted input 2" do
      txt = "Joe 1 10\nMarcus 10"
      processor = Game.new(txt)
      expect{ processor.process_rounds }.to raise_error(SystemExit).and output("\"Joe 1 10\" can't be processed.\n").to_stderr
    end

    it "detects negative scores" do
      txt = "Joe -1\nMarcus 10"
      processor = Game.new(txt)
      expect{ processor.process_rounds }.to raise_error(SystemExit).and output("Invalid score on \"Joe -1\".\n").to_stderr
    end

    it "detects scores bigger than 10" do
      txt = "Joe 11\nMarcus 10"
      processor = Game.new(txt)
      expect{ processor.process_rounds }.to raise_error(SystemExit).and output("Invalid score on \"Joe 11\".\n").to_stderr
    end

    it "detects invalid letters or words on scores" do
      txt = "Joe A\nMarcus 10"
      processor = Game.new(txt)
      expect{ processor.process_rounds }.to raise_error(SystemExit).and output("Invalid score on \"Joe A\".\n").to_stderr
    end

    it "returns a Hash with players as keys and an array of scores as values" do
      txt = "Joe 1\nJoe 9\nMarcus F"
      processor = Game.new(txt)
      processor.process_rounds
      expect(processor.players_rounds).to eq({'Joe' => ['1', '9'], 'Marcus' => ['F']})
    end
  end
end
