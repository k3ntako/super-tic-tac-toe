class CLI
  def self.put_string(text)
    puts text
  end

  def self.put_board(board)
    board_str = ""

    board.each_with_index do |row, row_idx|
      board_str += self.generate_board_row(row, row_idx)
    end

    puts board_str
  end

  def self.generate_board_row(row, row_idx)
    row_str = ""

    row.each_with_index do |_, square_idx|
      row_str += "   "
      row_str += square_idx < 2 ? "|" : "\n"
    end

    # add row divider
    if row_idx < 2
      row_str += "-----------\n"
    end

    row_str
  end
end