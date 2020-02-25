class GameMessenger
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def display_board(board)
    @user_interface.display_board board.state
  end

  def display_move_instruction
    instruction = 'Enter a number to make a move in the corresponding square:'
    @user_interface.display_message instruction
  end

  def display_game_over_with_winner(winner)
    message = "Game Over: #{winner.mark} Wins"
    @user_interface.display_message message
  end

  def display_game_over_with_tie
    message = 'Game Over: Tie!'
    @user_interface.display_message message
  end
end
