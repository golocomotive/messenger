module Messenger
  class Receipt < ActiveRecord::Base
    delegate :sender, to: :message

    def read!
      touch(:read_at)
    end

    def unread!
      update_column :read_at, nil
    end
  end
end
