module Messenger
  class MessagePresenter
    attr_reader :message

    delegate :created_at, :sender ,:subject, :receipts, to: :message

    def initialize(message)
      @message = message
    end

    def sent_at
      created_at
    end

    def to
      @to ||= 'hello' # encoded_recipients
    end
  end
end
