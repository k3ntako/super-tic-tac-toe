class MockStrategy
  attr_reader :triggered_actions
  def initialize
    @triggered_actions = []
  end

  def get_move(board:)
    @triggered_actions.push('get_move')
  end
end
