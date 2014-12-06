module Messenger
  class Group < ActiveRecord::Base
    concerned_with(
      :group_active_record,
      :group_class_methods,
      :group_extensions,
      :group_instance_methods,
      :group_search,
      :group_scopes )
  end
end
