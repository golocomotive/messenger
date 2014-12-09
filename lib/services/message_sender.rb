module Services
  class MessageSender
    attr_accessor :message, :recipients

    def initialize(message, recipients)
      @message    = message
      @recipients = Array.wrap recipients
    end

    def transmit
      recipients.each do |recipient|
        Receipt.create(message: message, recipient: recipient)
      end
    end
  end
end
