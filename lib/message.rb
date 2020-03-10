class Message
  def initialize
    @static_messages = {}
  end

  def generate(key:, params: nil)
    return static_messages[key] if params.nil?

    # if "key" is ":move_instruction", then move_instruction will be called with params
    # all static and dynamic message should be defined in subclasses
    send(key, params)
  end

  private

  attr_reader :static_messages
end
