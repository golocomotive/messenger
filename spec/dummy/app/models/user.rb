class User < ActiveRecord::Base
  has_many :memberships, class_name: 'Messenger::Membership'
  has_many :groups, through: :memberships, class_name: 'Messenger::Group'

  validates :name, presence: true, uniqueness: true
end
