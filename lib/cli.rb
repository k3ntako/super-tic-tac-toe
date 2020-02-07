# frozen_string_literal: true

# Resonsible for any input/output via the command line
class CLI
  def display_message(text)
    puts text
  end

  def display_board(board)
    formatted_board = format_board_for_display board
    display_message formatted_board
  end

  private

  def format_board_for_display(board)
    board_str = ''

    board.each_with_index do |row, row_idx|
      board_str += generate_board_row(row, row_idx)
    end

    board_str
  end

  def generate_board_row(row, row_idx)
    row_str = ''

    row.each_with_index do |_, square_idx|
      row_str += '   '
      row_str += square_idx < 2 ? '|' : "\n"
    end

    # add row divider
    row_str += "-----------\n" if row_idx < 2

    row_str
  end
end
