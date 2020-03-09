require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'
require_relative './game_message_generator'
require_relative './game_state'
require_relative './input_validator'
require_relative './player'
require_relative './computer'
require_relative './board'

class GameGenerator
  def create_a_game(user_interface:, opponent: :human)
    opponent_player = opponent == :human ? Player.new(user_interface, 'O') : Computer.new(mark: 'O')

    players = [
      Player.new(user_interface, 'X'),
      opponent_player
    ]

    game_messenger = GameMessenger.new(
      user_interface: user_interface,
      game_message_generator: GameMessageGenerator.new
    )

    game_state = GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      input_validator: InputValidator.new,
      board: Board.new,
      players: players
    )

    Game.new(
      game_state: game_state
    )
  end
end
