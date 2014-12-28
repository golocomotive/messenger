module Services
  class MessagesControllerCreate
    attr_reader :params, :sender

    def initialize(sender:, params:)
      @params = params
      @sender = sender
    end

    def run
      message = Messenger::Message.new(sender: sender, subject: subject, body: body)
      Services::MessageSender.new(message: message, recipients: recipients).deliver
    end

    private

      def body
        params[:body]
      end

      def recipients
        list = params[:receivers].inject({}) do |result, item|
          item.symbolize_keys
          klass = item[:class]
          id    = item[:id]
          (result[klass] ||= []) << Integer(id)
          result
        end

        list.keys.inject([]) do |result, class_name|
          klass = class_name.safe_constantize
          result.push(klass.where(id: list[class_name]).all) if klass
          result
        end.flatten
      end

      def subject
        params[:subject]
      end
  end
end