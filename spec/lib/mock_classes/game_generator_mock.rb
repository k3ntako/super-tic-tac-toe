class MockGameGenerator
  attr_reader :triggered_actions, :last_game_created
  def initialize
    @triggered_actions = []
    @last_game_created = nil
  end

  def create_a_game(user_interface:, opponent:, strategy:)
    @triggered_actions.push('create_a_game')

    @last_game_created = MockGame.new(game_state: nil, players: [:human, opponent])
    @last_game_created
  end
end
