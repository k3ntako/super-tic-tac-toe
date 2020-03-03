class MoveValidator
  def initialize(game_messenger: nil)
    @game_messenger = game_messenger
  end

  def error_for_move(board, position_input)
    error_for_integer(position_input) || error_for_square(board, position_input)
  end

  private

  def error_for_integer(pos_input)
    return :not_valid_integer unless int_or_str?(pos_input) && parses_to_integer?(pos_input)
  end

  def error_for_square(board, position)
    return :square_unavailable unless board.position_available? position
  end

  def int_or_str?(position_input)
    (position_input.is_a? Integer) || (position_input.is_a? String)
  end

  def parses_to_integer?(position_input)
    # Strings will be converted to integer using Integer
    # Valid strings: '1', '  1 ', ' 2 \n', ' 2 \r\n'
    # Invalid strings: '', 'aa', 'a1', '1a', '1 2', '1.1'
    begin
      Integer position_input
    rescue ArgumentError
      return false # Failed to parse String into Integer
    end

    true
  end
end
