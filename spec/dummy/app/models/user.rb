class User < ActiveRecord::Base
  has_many :groups, through: :memberships, class_name: 'Messenger::Group'
  has_many :memberships, class_name: 'Messenger::Membership', as: :member
  has_many :messages, class_name: 'Messenger::Message', through: :receipts
  has_many :receipts, class_name: 'Messenger::Receipt', as: :recipient

  validates :name, presence: true, uniqueness: true
end
