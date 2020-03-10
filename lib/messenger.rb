class Messenger
  def initialize(user_interface:, message_generator:)
    @user_interface = user_interface
    @message_generator = message_generator
  end

  def display(message:, params: nil)
    message = message_generator.generate(key: message, params: params)
    user_interface.display_message message
  end

  def display_empty_line
    user_interface.display_empty_line
  end

  def clear_output
    user_interface.clear_output
  end

  private

  attr_reader :user_interface, :message_generator
end
