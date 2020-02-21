class Game
  def initialize(board, player)
    @board = board
    @player_one = player
  end

  def start
    display_board
    display_move_instruction

    position = @player_one.get_move
    @player_one.make_move(@board, position)

    display_board
  end

  private

  def display_board
    @user_interface.display_board @board.state
  end

  def display_move_instruction
    instruction = 'Enter a number to make a move in the corresponding square:'
    @user_interface.display_message instruction
  end
end
