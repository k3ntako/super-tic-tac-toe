class TestCLI
  attr_reader :diplayed_messages, :triggered_actions
  def initialize
    @diplayed_messages = []
    @triggered_actions = []
  end

  def display_message(message)
    @diplayed_messages.push message
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
end
