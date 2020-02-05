require_relative "../../lib/cli"

RSpec.describe "CLI" do
  context "when string is passed into CLI.puts" do
    it "should print the string to the console" do
      text = "This should be printed to the console"
      expect { CLI.putString text }.to output(text + "\n").to_stdout
    end
  end
end
