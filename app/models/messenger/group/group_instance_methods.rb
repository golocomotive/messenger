module Messenger
  class Group < ActiveRecord::Base
    def members
      classes   = memberships.select(:member_type).distinct.pluck(:member_type)
      classes.inject([]) do |result, klass|
        ids     = memberships.where(member_type: klass).pluck(:member_id)
        result += klass.constantize.where(id: ids).all
      end
    end
  end
end
