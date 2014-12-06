module Messenger
  class Message < ActiveRecord::Base
    belongs_to :sender, polymorphic: true

    validates :sender, presence: true
    validates :subject, presence: true, allow_blank: false
  end
end
