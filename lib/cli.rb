class CLI
  def display_message(text)
    puts text
  end

  def get_user_input
    gets.chomp
  end

  def display_empty_line
    display_message ''
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
      board_str += generate_board_row(row, row_idx, board_state.length)
    end

    board_str + "\n"
  end

  def generate_board_row(row, row_idx, width)
    row_str = ''

    row.each_with_index do |square, square_idx|
      square_text = get_square_text(square, row_idx, square_idx, width)

      row_str += " #{square_text} "
      row_str += square_idx < (width - 1) ? '|' : "\n"
    end

    # add row divider
    row_str += divider(width: width) if row_idx < (width - 1)

    row_str
  end

  def get_square_text(square, row_idx, square_idx, width)
    text = square

    if square.nil?
      row_base = row_idx * width

      # Add one because it's not zero-based numbering for readability
      text = (row_base + square_idx + 1).to_s
    end

    text = center_square_text(text: text, width: width)

    text
  end

  def center_square_text(text:, width:)
    length_difference = (width**2).to_s.length - text.length
    length_difference.times do |idx| # centers text as best as possible
      if idx.even?
        text += ' '
      else
        text = ' ' + text
      end
    end

    text
  end

  def divider(width:)
    spaces = 2 * width
    vertical_dividers = width - 1
    position_name_length = width * (width**2).to_s.length

    char_count = position_name_length + spaces + vertical_dividers

    '-' * char_count + "\n"
  end
end
