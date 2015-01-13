module Messenger
  class Message < ActiveRecord::Base
    def self.draft
      where sent_at: nil
    end

    def self.sent
      where.not(sent_at: nil)
    end

    def self.unread
      joins(:receipts)
        .merge(Receipt.unread)
    end
  end
end
