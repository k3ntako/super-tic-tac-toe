MESSAGES = {
  welcome: 'Welcome to a game of Tic-Tac-Toe!',
  title: 'Super TicTacToe',
  not_valid_integer: 'Make sure it\'s an integer and try again!',
  square_unavailable: 'You can\'t make a move there, try again!'
}.freeze

class GameMessageGenerator
  def message(key:, params: nil)
    p params
    return MESSAGES[key] if params.nil?

    self.send(key, params)
  end

  def game_over(params)
    return 'Game Over: Tie!' if params[:winner].nil?

    "Game Over: #{params[:winner]} Wins!"
  end

  def move_instruction(params)
    "Enter a number to make a move in the corresponding square (#{params[:current_player]}'s turn):"
  end
end
