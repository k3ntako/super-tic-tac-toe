class UserInterface
  def initialize(platform)
    @platform = platform
  end

  def display_message(message)
    @platform.display_message message
  end

  def display_board(board)
    @platform.display_board board
  end

  def get_user_input
    @platform.get_user_input
  end
end
