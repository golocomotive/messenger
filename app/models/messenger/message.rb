module Messenger
  class Message < ActiveRecord::Base
    concerned_with(
      :message_active_record,
      :message_class_methods,
      :message_extensions,
      :message_instance_methods,
      :message_search,
      :message_scopes )
  end
end
