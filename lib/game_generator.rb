require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'
require_relative './game_message_generator'
require_relative './game_state'
require_relative './input_validator'
require_relative './human_player'
require_relative './computer_player'
require_relative './board'

class GameGenerator
  def create_a_game(user_interface:, opponent:)
    opponent_player = opponent == :human ? HumanPlayer.new(user_interface, 'O') : ComputerPlayer.new(mark: 'O')

    players = [
      HumanPlayer.new(user_interface, 'X'),
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

    Game.new(game_state: game_state)
  end
end
