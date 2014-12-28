class User < ActiveRecord::Base
  acts_as_recipient

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
