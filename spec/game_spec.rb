# frozen_string_literal: true

# require File.expand_path('../lib/text_processor', __dir__)
require File.expand_path('../lib/game', __dir__)

RSpec.describe Game do
  context ".new" do
    it "breaks document into array of lines" do
      txt = "Joe 1\nMarcus 10"
      processor = Game.new(txt)
      expect(processor.file).to eq(["Joe 1", "Marcus 10"]) 
    end

    it "stops program if file is empty string" do
      expect{ Game.new('') }.to output('File input is empty.').to_stderr 
    end
  end
end
