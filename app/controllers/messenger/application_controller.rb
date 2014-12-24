module Messenger
  class ApplicationController < ::ApplicationController
    def is_logged_in?
      !!sender
    end

    def sender
      current_user
    end
  end
end
