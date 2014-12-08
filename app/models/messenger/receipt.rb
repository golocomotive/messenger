module Messenger
  class Receipt < ActiveRecord::Base
    concerned_with(
      :receipt_active_record,
      :receipt_class_methods,
      :receipt_extensions,
      :receipt_instance_methods,
      :receipt_search,
      :receipt_scopes )
  end
end
