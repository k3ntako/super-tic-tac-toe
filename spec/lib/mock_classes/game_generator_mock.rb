require_relative './game_mock'

class MockGameGenerator
  attr_reader :triggered_actions
  def initialize
    @triggered_actions = []
  end

  def create_a_game(*args)
    @triggered_actions.push(
      method: 'create_a_game',
      parameters: args
    )

    MockGame.new
  end
end
