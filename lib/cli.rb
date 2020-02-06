class CLI
  def self.put_string(text)
    puts text
  end

  def self.put_board
    puts "   |   |   \n" +
    "-----------\n" +
    "   |   |   \n" +
    "-----------\n" +
    "   |   |   \n"
  end
end