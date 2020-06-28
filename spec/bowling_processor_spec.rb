require File.expand_path('../bin/bowling_processor', __dir__)

RSpec.describe '#process_bowling_report' do
  let(:file) do
    "Jeff 10\nJohn 3\nJohn 7\nJeff 7\nJeff 3\nJohn 6\nJohn 3\nJeff 9\nJeff 0\nJohn 10\nJeff 10\nJohn 8\nJohn 1"\
    "\nJeff 0\nJeff 8\nJohn 10\nJeff 8\nJeff 2\nJohn 10\nJeff F\nJeff 6\nJohn 9\nJohn 0\nJeff 10\nJohn 7\nJohn 3"\
    "\nJeff 10\nJohn 4\nJohn 4\nJeff 10\nJeff 8\nJeff 1\nJohn 10\nJohn 9\nJohn 0"
  end

  it 'outputs standardized bowling score report' do
    expect { process_bowling_report(file) }.to output(
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
