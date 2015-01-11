module Util
  class EncodeDecodeClasses
    attr_reader :encoded_recipient_string, :recipients_hash

    def self.encode(receipts)
      new.encode receipts
    end

    def self.decode(string)
      new(string).decode
    end

    def initialize(encoded_recipient_string = nil)
      @encoded_recipient_string = encoded_recipient_string
    end

    def decode
      lookup.values.flatten
    end

    def encode(receipts)
      groups = receipts.inject({}) do |result, receipt|
        (result[receipt.recipient_type.underscore] ||= []).push receipt.recipient_id
        result
      end

      groups.each_pair.inject([]) do |result, (key, value)|
        result << "#{key}=#{value.join(',')}"
      end.join('&')
    end

    def missing
      lookup.each_pair.inject({}) do |result, (klass, list)|
        missing_ids = (list.map(&:id).to_set ^ recipients_hash[klass].to_set).to_a
        result[klass] = missing_ids if missing_ids.any?
        result
      end
    end

    private

      def lookup
        @lookup ||= recipients_hash.each_pair.inject({}) do |result, (klass, ids)|
          result[klass] = klass.try(:where, id: ids).try(:all) || []
          result
        end
      end

      def recipients_hash
        @hash ||= (encoded_recipient_string || '').split('&').inject({}) do |result, list|
          (klass, ids)     = list.split('=')
          klass            = klass.camelize.safe_constantize
          ids              = ids.split(',').map(&:to_i)
          (result[klass] ||= []).concat ids
          result
        end
      end
  end
end