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
    formatted_board = @platform.format_board_for_display board
    @platform.display_message formatted_board
  end
end
