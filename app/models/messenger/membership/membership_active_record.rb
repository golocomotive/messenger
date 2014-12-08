module Messenger
  class Membership < ActiveRecord::Base
    belongs_to :group, inverse_of: :memberships
    belongs_to :member, polymorphic: true
  end
end
