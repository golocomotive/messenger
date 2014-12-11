module Messenger
  class Message < ActiveRecord::Base
    def recipients
      classes   = receipts.select(:recipient_type).distinct.pluck(:recipient_type)
      classes.inject([]) do |result, klass|
        ids     = receipts.where(recipient_type: klass).pluck(:recipient_id)
        result += klass.constantize.where(id: ids).all
      end
    end
  end
end
