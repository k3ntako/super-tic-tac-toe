class GameState
  attr_reader :board

  def initialize(game_messenger:, game_end_evaluator:, board:, players:)
    @game_messenger = game_messenger
    @game_end_evaluator = game_end_evaluator
    @board = board
    @players = players
    @current_player_idx = 0
    @prev_move_position = nil
  end

  def alternate_current_player
    @current_player_idx = @current_player_idx.zero? ? 1 : 0
  end

  def player_move
    loop do
      position = current_player.make_move(board: board)

      @prev_move_position = position
      break
    rescue IntegerError, SquareUnavailableError => e
      display_board_with_messages_for_move bottom_messages: [[e.message_symbol]]
    end
  end

  def display_board_with_messages_for_move(top_message: nil, bottom_messages: [])
    bottom_messages = bottom_messages.push(move_instruction_message)
    display_board_with_messages(top_message: top_message, bottom_messages: bottom_messages)
  end

  def display_board_with_messages(top_message: nil, bottom_messages: [])
    top_message ||= default_top_message

    @game_messenger.display_board_with_messages(
      top_message: top_message,
      board: @board,
      bottom_messages: bottom_messages
    )
  end

  def game_over?
    @game_end_evaluator.game_over?(@board)
  end

  def player_won?
    @game_end_evaluator.player_won?(@board)
  end

  def previous_player
    previous_player_idx = @current_player_idx.zero? ? 1 : 0
    players[previous_player_idx]
  end

  private

  attr_reader :players

  def default_top_message
    return [:match_up, { players: players }] if @prev_move_position.nil?

    [
      :previous_move,
      {
        player: previous_player.mark,
        position: @prev_move_position
      }
    ]
  end

  def move_instruction_message
    [:move_instruction, { current_player: current_player.mark }]
  end

  def current_player
    players[@current_player_idx]
  end
end
