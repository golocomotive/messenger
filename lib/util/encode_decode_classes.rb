module Util
  class EncodeDecodeClasses
    attr_reader :receipts

    def self.encode(*receipts)
      new(receipts).encode
    end

    def self.decode(string)
      string.split('&').map do |list|
        (klass, ids) = list.split('=')
        klass        = klass.camelize.safe_constantize
        ids          = ids.split(',').map(&:to_i)
        klass.try(:where, id: ids).try(:all) || []
      end.flatten
    end

    def initialize(*receipts)
      @receipts = receipts.flatten
    end

    def encode
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