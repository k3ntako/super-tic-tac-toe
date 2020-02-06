require_relative "./cli"

class TicTacToe
  def print_welcome
    welcome_message = "Welcome to a game of Tic-Tac-Toe!"
    CLI.put_string welcome_message
  end
end