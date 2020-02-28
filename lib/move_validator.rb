class MoveValidator
  def initialize(game_messenger: nil)
    @game_messenger = game_messenger
  end

  def move_valid?(board, position_input)
    valid_integer?(position_input) && empty_square?(board, position_input)
  end

  private

  def valid_integer?(pos_input)
    if !int_or_str?(pos_input) || !parses_to_integer?(pos_input)
      @game_messenger.display_not_valid_integer
      return false
    end

    true
  end

  def empty_square?(board, position)
    is_empty = board.position_available? position

    @game_messenger.display_square_unavaliable unless is_empty

    is_empty
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
