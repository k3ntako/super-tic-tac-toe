# frozen_string_literal: true

# UserInterface deals with the specific platform this game is running on
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
