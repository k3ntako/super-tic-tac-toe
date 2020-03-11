require_relative '../../lib/human_player'

RSpec.describe HumanPlayer do
  let(:cli) { CLI.new }
  let(:user_interface) { UserInterface.new(cli) }
  let(:board) { Board.new }
  let(:player) { HumanPlayer.new(user_interface, 'X') }

  describe 'get_move' do
    it 'should call get_user_input and receive the input' do
      input_text = 'input text'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_text)

      user_move = player.get_move(board: board)

      expect(user_move).to eql input_text
    end
  end
end
