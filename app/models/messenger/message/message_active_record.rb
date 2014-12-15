module Messenger
  class Message < ActiveRecord::Base
    belongs_to :sender, polymorphic: true
    has_many :receipts, inverse_of: :message

    validates :sender, presence: true
    validates :subject, presence: true, allow_blank: false

    after_save :encode_recipients

    private

      def encode_recipients
        update_column(:encoded_recipients, encoding) if encoded_recipients.nil?
      end

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
