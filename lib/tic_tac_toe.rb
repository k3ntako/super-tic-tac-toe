require_relative "./cli"

class TicTacToe
  def printWelcome
    welcome_message = "Welcome to a game of Tic-Tac-Toe!"
    CLI.putString welcome_message
  end
end