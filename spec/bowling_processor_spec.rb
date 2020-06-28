# frozen_string_literal: true

require File.expand_path('../bin/bowling_processor', __dir__)

RSpec.describe '#process_bowling_report' do
  let(:file) {"Jeff 10
  John 3
  John 7
  Jeff 7
  Jeff 3
  John 6
  John 3
  Jeff 9
  Jeff 0
  John 10
  Jeff 10
  John 8
  John 1
  Jeff 0
  Jeff 8
  John 10
  Jeff 8
  Jeff 2
  John 10
  Jeff F
  Jeff 6
  John 9
  John 0
  Jeff 10
  John 7
  John 3
  Jeff 10
  John 4
  John 4
  Jeff 10
  Jeff 8
  Jeff 1
  John 10
  John 9
  John 0"}
  it "outputs standardized bowling score report" do
    expect{ process_bowling_report(file) }.to output(
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Frame     |1   |2   |3   |4   |5   |6   |7   |8   |9   |10    |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Jeff                                                          |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Pinfalls  |  X |7 / |9 0 |  X |0 8 |8 / |F 6 |  X |  X |X 8 1 |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Score     |20  |39  |48  |66  |74  |84  |90  |120 |148 |167   |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|John                                                          |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Pinfalls  |3 / |6 3 |  X |8 1 |  X |  X |9 0 |7 / |4 4 |X 9 0 |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"\
      "|Score     |16  |25  |44  |53  |82  |101 |110 |124 |132 |151   |\n"\
      "+----------+----+----+----+----+----+----+----+----+----+------+\n"
    ).to_stdout
  end
end