require_relative './game_mock'

class MockGameConfigurator
  attr_reader :triggered_actions, :last_game_created
  def initialize(user_interface:, input_validator:, game_generator:)
    @triggered_actions = []
    @last_game_created = nil
  end

  def create_a_game
    @triggered_actions.push 'create_a_game'

    @last_game_created = MockGame.new(game_state: nil, players: %i[human human])
    @last_game_created
  end
end
