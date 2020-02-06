require_relative "../../lib/board"
require_relative "../../lib/cli"

RSpec.describe "CLI" do
  context "when string is passed into CLI.put_string" do
    it "should print the string to the console" do
      cli = CLI.new

      text = "This should be printed to the console"
      expect { cli.put_string text }.to output(text + "\n").to_stdout
    end
  end

  context "when CLI.put_board is called with an empty board" do
    it "should print an empty board to the console" do
      cli = CLI.new

      board = Board.new
      empty_board = board.get_board

      expected_output =
        "   |   |   \n" +
        "-----------\n" +
        "   |   |   \n" +
        "-----------\n" +
        "   |   |   \n"

      expect { cli.put_board empty_board }.to output(expected_output).to_stdout
    end
  end
end
