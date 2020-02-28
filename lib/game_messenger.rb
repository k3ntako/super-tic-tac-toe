class GameMessenger
  def initialize(user_interface:, messages: {})
    @messages = messages
    @user_interface = user_interface
  end

  def display(message:)
    @user_interface.display_message messages[message]
  end

  def display_board(board)
    @user_interface.display_board board.state
  end

  private

  attr_reader :messages
end
