require 'haml'
require 'messenger/engine'

module Messenger
  def acts_as_recipient
    self.include Messenger::Associations
  end

  module Associations
    def self.included(base)
      base.class_eval do
        has_many :groups,       class_name: 'Messenger::Group',   through: :memberships
        has_many :memberships,  class_name: 'Messenger::Membership', as: :member
        has_many :messages,     class_name: 'Messenger::Message', through: :receipts
        has_many :receipts,     class_name: 'Messenger::Receipt', as: :recipient
      end
    end
  end
end

ActiveRecord::Base.extend(Messenger)
