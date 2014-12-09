module Messenger
  class Receipt < ActiveRecord::Base
    delegate :sender, to: :message
  end
end
