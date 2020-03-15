require_relative '../../lib/errors/square_unavailable_error'

RSpec.describe SquareUnavailableError do
  it 'should be subtype of StandardError' do
    expect(SquareUnavailableError).to be < StandardError
  end

  describe 'message_symbol' do
    it 'should return message symbol' do
      square_unavailable = SquareUnavailableError.new
      expect(square_unavailable.message_symbol).to eq(:square_unavailable)
    end
  end
end
