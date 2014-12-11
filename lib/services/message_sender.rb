module Services
  class MessageSender
    attr_accessor :message, :recipients

    def initialize(message: message, recipients: recipients)
      @message    = message
      @recipients = expanded_list(Array.wrap recipients)
    end

    def deliver
      recipients.each do |recipient|
        recipient.receipts.create(message: message)
      end
    end

    def deliver_in_batches
      receipts = recipients.map do |recipient|
        Messenger::Receipt.new(message: message, recipient: recipient)
      end

      Messenger::Receipt.import receipts, validate: false
    end

    private

      def expanded_list(list)
        list = list.map do |recipient|
          recipient.respond_to?(:members) ? recipient.members : recipient
        end

        list.flatten
      end
  end
end
