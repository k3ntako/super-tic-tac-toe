require_relative './message'

class GameMessage < Message
  def initialize
    @static_messages = {
      welcome: 'Welcome to a game of Tic-Tac-Toe!',
      not_valid_integer: 'Make sure it\'s an integer and try again!',
      square_unavailable: 'You can\'t make a move there, try again!'
    }
  end

  private

  def move_instruction(params)
    "Enter a number to make a move in the corresponding square (#{params[:current_player]}'s turn):"
  end

  def game_over(params)
    return 'Game Over: Tie!' if params[:winner].nil?

    "Game Over: #{params[:winner]} Wins!"
  end

  def previous_move(params)
    "Previous Move: #{params[:player]} on #{params[:position]}"
  end

  def match_up(params)
    player_one = params[:players][0]
    player_two = params[:players][1]

    player_one_type = player_one.class.name.gsub('Player', '')
    player_two_type = player_two.class.name.gsub('Player', '')

    "#{player_one_type} (#{player_one.mark}) vs. #{player_two_type} (#{player_two.mark})"
  end
end
