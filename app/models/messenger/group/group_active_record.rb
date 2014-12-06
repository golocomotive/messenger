module Messenger
  class Group < ActiveRecord::Base
    belongs_to :owner, class_name: Rails.application.config.sender_model_name
    has_many :memberships
    has_many :members, class_name: Rails.application.config.sender_model_name, through: :memberships

    validates :name, presence: true, allow_blank: false, uniqueness: { scoped: :owner }
  end
end
