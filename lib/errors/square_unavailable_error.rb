class SquareUnavailableError < StandardError
  def message_symbol
    :square_unavailable
  end
end
