module Messenger
  class MessagePresenter
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end
end
