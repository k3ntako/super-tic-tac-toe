require_relative "../../lib/tic_tac_toe"

RSpec.describe "TicTacToe" do
  context "when the user starts the game" do
    it "should print a welcome message" do
      expect { TicTacToe.new }.to output("Welcome to a game of Tic-Tac-Toe!\n").to_stdout
    end
  end
end