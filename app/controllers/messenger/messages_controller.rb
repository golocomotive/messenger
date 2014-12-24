module Messenger
  class MessagesController < ApplicationController
    attr_reader :message

    def create
    end

    def destroy
      message.destroy
    end

    def index
      render locals: { messages: current_user.messages }
    end

    def new
    end

    def show
      render locals: { message: message }
    end

    private

      def message
        id = params.fetch(:id, nil)
        @message = current_user.messages.where(id: id).first
      end

      def whitelisted_params
        params.require(:message).permit(:body, :recipient, :sender, :subject)
      end
  end
end
