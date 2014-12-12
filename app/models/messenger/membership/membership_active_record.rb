module Messenger
  class Membership < ActiveRecord::Base
    belongs_to :group, inverse_of: :memberships
    belongs_to :member, polymorphic: true

    validates :group, presence: true
    validates :member, presence: true
    validates :member_id, uniqueness: { scope: :member_type }
    validates :member_type, exclusion: { in: %w(Messenger::Group) }
  end
end
