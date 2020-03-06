class TestCLI
  attr_reader :displayed_messages, :triggered_actions
  attr_accessor :fake_user_inputs
  def initialize
    @displayed_messages = []
    @triggered_actions = []
    @fake_user_inputs = []
    @fake_user_input_idx = -1
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

  def display_empty_line
    @triggered_actions.push 'display_empty_line'
  end

  def clear_output
    @triggered_actions.push 'clear_output'

    true
  end

  def get_user_input
    @triggered_actions.push 'get_user_input'
    @fake_user_input_idx += 1

    @fake_user_inputs[@fake_user_input_idx]
  end
end
