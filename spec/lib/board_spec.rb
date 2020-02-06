require_relative "../../lib/board"

RSpec.describe "Board" do
  context "when Board#get_board is called" do
    it "should return an array of arrays with three nils in each" do
      board_instance = Board.new
      board = board_instance.get_board

      expect(board).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil],
      ]
    end
  end
end