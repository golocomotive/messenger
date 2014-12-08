module Messenger
  class Group < ActiveRecord::Base
    belongs_to :owner, class_name: Rails.application.config.sender_model_name
    has_many :memberships, inverse_of: :group

    validates :name, presence: true, allow_blank: false, uniqueness: { scope: :owner }
    validates :owner, presence: true
  end
end
