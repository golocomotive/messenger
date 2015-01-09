module Messenger
  class Message < ActiveRecord::Base
    def encode_recipients!
      update_column(:encoded_recipients, encoding) if encoded_recipients.blank?
    end

    def recipients
      classes   = receipts.select(:recipient_type).distinct.pluck(:recipient_type)
      classes.inject([]) do |result, klass|
        ids     = receipts.where(recipient_type: klass).pluck(:recipient_id)
        result += klass.constantize.where(id: ids).all
      end
    end

    def recipients=(*list)
      self.receipts = Array(list).flatten.map { |recipient| receipts.build(recipient: recipient) }
    end

    def sent_at
      created_at
    end

    private

      def encoding
        groups = receipts.inject({}) do |result, receipt|
          (result[receipt.recipient_type.underscore] ||= []).push receipt.recipient_id
          result
        end

        groups.each_pair.inject([]) do |result, (key, value)|
          result << "#{key}=#{value.join(',')}"
        end.join('&')
      end
  end
end
