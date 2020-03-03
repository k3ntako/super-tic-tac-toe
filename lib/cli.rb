class CLI
  def display_message(text)
    puts text
  end

  def get_user_input
    gets.chomp
  end

  def display_board(board_state)
    formatted_board = format_board_for_display board_state
    display_message formatted_board
  end

  def clear_output
    system 'clear'
  end

  private

  def format_board_for_display(board_state)
    board_str = "\n"

    board_state.each_with_index do |row, row_idx|
      board_str += generate_board_row(row, row_idx)
    end

    board_str + "\n"
  end

  def generate_board_row(row, row_idx)
    row_str = ''

    row.each_with_index do |square, square_idx|
      square_text = get_square_text(square, row_idx, square_idx)

      row_str += " #{square_text} "
      row_str += square_idx < 2 ? '|' : "\n"
    end

    # add row divider
    row_str += "-----------\n" if row_idx < 2

    row_str
  end

  def get_square_text(square, row_idx, square_idx)
    if square.nil?
      row_base = row_idx * 3

      # Add one because it's not zero-based numbering for readability
      return row_base + square_idx + 1
    end

    square
  end
end
