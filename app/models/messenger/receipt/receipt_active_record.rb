module Messenger
  class Receipt < ActiveRecord::Base
    belongs_to :message
    belongs_to :recipient, polymorphic: true

    validates :message, uniqueness: { scope: [:recipient_id, :recipient_type] }, presence: true
    validates :recipient, presence: true
  end
end
