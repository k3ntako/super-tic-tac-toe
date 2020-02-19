# frozen_string_literal: true

# UserInputValidator
class UserInputValidator
  def move_valid_integer?(input_string)
    # Requires an integer or string
    if (!input_string.is_a? Integer) && (!input_string.is_a? String)
      return false
    end

    # Strings will be converted to integer using Integer
    # Valid strings: '1', '  1 ', ' 2 \n', ' 2 \r\n'
    # Invalid strings: '', 'aa', 'a1', '1a', '1 2', '1.1'
    begin
      Integer input_string
    rescue ArgumentError
      return false # Failed to parse String into Integer
    end

    true
  end

  def move_on_empty_square?(board, position)
    board.position_available? position
  end
end
