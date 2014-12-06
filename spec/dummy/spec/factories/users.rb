require 'uuid'

FactoryGirl.define do
  factory :user do
    name { UUID.generate }
  end
end
