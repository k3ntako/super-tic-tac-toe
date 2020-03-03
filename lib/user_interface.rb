class UserInterface
  def initialize(platform)
    @platform = platform
  end

  def display_message(message)
    @platform.display_message message
  end

  def display_board(board_state)
    @platform.display_board board_state
  end

  def get_user_input
    @platform.get_user_input
  end

  def clear_output
    @platform.clear_output
  end
end
