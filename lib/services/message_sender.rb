module Services
  class MessageSender
    attr_accessor :message, :recipients

    def initialize(message, recipients)
      @message    = message
      @recipients = Array.wrap recipients
    end
  end
end
