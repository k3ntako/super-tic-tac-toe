require_relative './messenger'

class GameMessenger < Messenger
  def display_board(board)
    @user_interface.display_board board.state
  end

  def display_board_with_messages(top_message:, board:, bottom_messages:)
    clear_output

    display(message: top_message[0], params: top_message[1])
    display_board(board)

    bottom_messages.each do |message|
      display(message: message[0], params: message[1])
    end
  end
end
