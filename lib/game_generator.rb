require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'

class GameGenerator
  def create_a_game(user_interface)
    game_args = {
      game_messenger: GameMessenger.new(user_interface),
      board: Board.new,
      game_end_evaluator: GameEndEvaluator.new,
      player_one: Player.new(user_interface, 'X'),
      player_two: Player.new(user_interface, 'O')
    }

    Game.new(game_args)
  end
end
