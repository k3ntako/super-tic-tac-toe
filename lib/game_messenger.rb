class GameMessenger
  def initialize(user_interface:, game_message_generator:)
    @user_interface = user_interface
    @game_message_generator = game_message_generator
  end

  def display(message:, params: nil)
    message = @game_message_generator.message(key: message, params: params)
    @user_interface.display_message message
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

    bottom_messages.each do |message|
      display(message: message[0], params: message[1])
    end
  end

  private

  attr_reader :messages
end
