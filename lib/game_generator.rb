require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'
require_relative './game_message'
require_relative './game_state'
require_relative './input_validator'
require_relative './human_player'
require_relative './computer_player'
require_relative './board'

PLAYER_ONE_MARK = 'X'.freeze
PLAYER_TWO_MARK = 'O'.freeze

class GameGenerator
  def create_a_game(user_interface:, strategy:, width:)
    opponent_player = if strategy.nil?
                        HumanPlayer.new(user_interface, PLAYER_TWO_MARK, InputValidator.new)
                      else
                        ComputerPlayer.new(mark: PLAYER_TWO_MARK, strategy: strategy)
                      end

    players = [
      HumanPlayer.new(user_interface, PLAYER_ONE_MARK, InputValidator.new),
      opponent_player
    ]

    game_messenger = GameMessenger.new(
      user_interface: user_interface,
      message_generator: GameMessage.new
    )

    game_state = GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      board: Board.new(width: width),
      players: players
    )

    Game.new(game_state: game_state)
  end
end
