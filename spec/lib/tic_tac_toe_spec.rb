require_relative "../../lib/tic_tac_toe"

RSpec.describe "TicTacToe" do
  context "when the user starts the game" do
    it "should print a welcome message" do
      tic_tac_toe = TicTacToe.new;
      expect { tic_tac_toe.print_welcome }.to output("Welcome to a game of Tic-Tac-Toe!\n").to_stdout
    end
  end
end