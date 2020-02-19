require_relative './cli'
require_relative './board'
require_relative './player'

class TicTacToe
  def initialize(user_interface)
    @user_interface = user_interface
    @board = Board.new
    @player_one = nil
  end

  def start
    initialize_players

    display_welcome
    display_board

    display_move_instruction

    position = @player_one.get_move
    @player_one.make_move(@board, position)

    display_board
  end

  private

  def initialize_players
    @player_one = Player.new(@user_interface, 'X')
  end

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end

  def display_board
    @user_interface.display_board @board.state
  end

  def display_move_instruction
    instruction = 'Enter a number to make a move in the corresponding square:'
    @user_interface.display_message instruction
  end
end
