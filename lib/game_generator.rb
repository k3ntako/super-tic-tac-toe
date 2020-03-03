require_relative './game'
require_relative './game_end_evaluator'
require_relative './game_messenger'
require_relative './game_state'
require_relative './move_validator'
require_relative './player'
require_relative './board'

MESSAGES = {
  welcome: 'Welcome to a game of Tic-Tac-Toe!',
  title: 'Super TicTacToe',
  move_instruction_x: 'Enter a number to make a move in the corresponding square (X\'s turn):',
  move_instruction_o: 'Enter a number to make a move in the corresponding square (O\'s turn):',
  game_over_X_wins: 'Game Over: X Wins',
  game_over_O_wins: 'Game Over: O Wins',
  game_over_with_tie: 'Game Over: Tie!',
  not_valid_integer: 'Make sure it\'s an integer and try again!',
  square_unavailable: 'You can\'t make a move there, try again!'
}.freeze

class GameGenerator
  def create_a_game(user_interface)
    players = [
      Player.new(user_interface, 'X'),
      Player.new(user_interface, 'O')
    ]

    game_messenger = GameMessenger.new(user_interface: user_interface, messages: MESSAGES)
    move_validator = MoveValidator.new(game_messenger: game_messenger)

    game_state = GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      move_validator: move_validator,
      board: Board.new,
      players: players
    )

    Game.new(
      game_messenger: game_messenger,
      game_state: game_state
    )
  end
end
