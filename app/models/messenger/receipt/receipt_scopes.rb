module Messenger
  class Receipt < ActiveRecord::Base
    def self.unread
      where(read_at: nil)
    end
  end
end
