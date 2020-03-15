require_relative '../../lib/errors/integer_error'

RSpec.describe IntegerError do
  it 'should be subtype of StandardError' do
    expect(IntegerError).to be < StandardError
  end

  describe 'message_symbol' do
    it 'should return message symbol' do
      integer_error = IntegerError.new
      expect(integer_error.message_symbol).to eq(:not_valid_integer)
    end
  end
end
