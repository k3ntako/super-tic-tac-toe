class MockGame
  attr_reader :triggered_actions, :players

  def initialize(game_state:, players:)
    @players = players
    @triggered_actions = []
  end

  def play
    @triggered_actions.push('start')
  end
end
