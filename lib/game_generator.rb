require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'
require_relative './game_state'
require_relative './player'
require_relative './board'

class GameGenerator
  def create_a_game(user_interface)
    players = [
      Player.new(user_interface, 'X'),
      Player.new(user_interface, 'O')
    ]

    game_state = GameState.new(
      game_end_evaluator: GameEndEvaluator.new,
      board: Board.new,
      players: players
    )

    Game.new(
      game_messenger: GameMessenger.new(user_interface),
      game_state: game_state
    )
  end
end
