require_relative "../../lib/board"
require_relative "../../lib/cli"

RSpec.describe "CLI" do
  context "when string is passed into CLI.put_string" do
    it "should print the string to the console" do
      text = "This should be printed to the console"
      expect { CLI.put_string text }.to output(text + "\n").to_stdout
    end
  end

  context "when CLI.put_board is called" do
    it "should print an empty board to the console" do
      expected_output = "   |   |   \n" +
      "-----------\n" +
      "   |   |   \n" +
      "-----------\n" +
      "   |   |   \n"

      expect { CLI.put_board }.to output(expected_output).to_stdout
    end
  end
end