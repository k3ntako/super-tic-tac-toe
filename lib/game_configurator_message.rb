require_relative './message'

class GameConfiguratorMessage < Message
  def initialize
    @static_messages = {
      ask_for_opponent_selection:
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:",
      ask_for_difficulty:
        "Choose the computer's difficulty level.\nEnter 1 for easy, 2 for medium, and 3 for impossible:",
      try_again: 'We got an invalid input, try again!',
      ask_for_board_width:
        "How wide do you want the baord to be?\nEnter a number from 3 to 12 (3 is standard):"
    }
  end
end
