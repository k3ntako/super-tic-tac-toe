class IntegerError < StandardError
  def message_symbol
    :not_valid_integer
  end
end
