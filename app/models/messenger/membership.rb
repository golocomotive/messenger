module Messenger
  class Membership < ActiveRecord::Base
    concerned_with(
      :membership_active_record,
      :membership_class_methods,
      :membership_extensions,
      :membership_instance_methods,
      :membership_search,
      :membership_scopes )
  end
end
