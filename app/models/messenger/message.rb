module Messenger
  class Message < ActiveRecord::Base
    belongs_to :sender
  end
end
