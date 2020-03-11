require_relative './message'

class GameConfiguratorMessage < Message
  def initialize
    @static_messages = {
      ask_for_opponent_selection:
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:",
      ask_for_difficulty:
        "Choose the computer's difficulty level.\nEnter 1 for easy, and 2 for medium:",
      try_again: 'We got an invalid input, try again!'
    }
  end
end
