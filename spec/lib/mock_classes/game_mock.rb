class MockGame
  attr_reader :triggered_actions

  def initialize(game_state: nil)
    @triggered_actions = []
  end

  def play
    @triggered_actions.push('start')
  end
end
