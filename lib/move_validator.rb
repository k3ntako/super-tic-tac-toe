class MoveValidator
  def valid_integer?(position_input)
    is_integer_or_string = (position_input.is_a? Integer) || (position_input.is_a? String)
    return false unless is_integer_or_string

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

  def empty_square?(board, position)
    board.position_available? position
  end
end
