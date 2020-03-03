class GameMessenger
  def initialize(user_interface:, messages:)
    @messages = messages
    @user_interface = user_interface
  end

  def display(message:)
    @user_interface.display_message messages[message]
  end

  def display_board(board)
    @user_interface.display_board board.state
  end

  def clear_output
    @user_interface.clear_output
  end

  def display_board_with_messages(top_message:, board:, bottom_messages:)
    clear_output

    display(message: top_message)
    display_board(board)

    bottom_messages.each do |message_key|
      display(message: message_key)
    end
  end

  private

  attr_reader :messages
end
