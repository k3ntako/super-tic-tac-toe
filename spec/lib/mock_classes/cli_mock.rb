class TestCLI
  attr_reader :displayed_messages, :triggered_actions
  def initialize
    @displayed_messages = []
    @triggered_actions = []
  end

  def display_message(message)
    @displayed_messages.push message
    @triggered_actions.push 'display_message'

    nil
  end

  def display_board(board_state)
    return nil unless board_state.is_a? Array

    board_str = board_state.flatten.map { |square| square || 'nil' }

    @triggered_actions.push 'display_board'

    display_message board_str.join(',')
  end

  def clear_output
    @triggered_actions.push 'clear_output'

    true
  end

  def get_user_input
    @triggered_actions.push 'get_user_input'

    'Called: get_user_input'
  end
end
