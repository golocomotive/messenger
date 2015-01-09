module Messenger
  class Message < ActiveRecord::Base
    belongs_to :sender, polymorphic: true
    has_many :receipts, inverse_of: :message

    validates :sender, presence: true
    validates :subject, presence: true, allow_blank: false
  end
end
