class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.where(name: 'Joe').first_or_create!
  end
end
