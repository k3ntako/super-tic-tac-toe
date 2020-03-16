require_relative './game_mock'

class MockGameConfigurator
  attr_reader :triggered_actions, :last_game_created
  def initialize(user_interface:, input_validator:, game_generator:, messenger:)
    @triggered_actions = []
    @last_game_created = nil
  end

  def create_a_game(*args)
    @triggered_actions.push(
      method: 'create_a_game',
      parameters: args
    )

    @last_game_created = MockGame.new
    @last_game_created
  end
end
