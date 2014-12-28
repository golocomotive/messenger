require 'uuid'

FactoryGirl.define do
  factory :user do
    name { UUID.generate }

    factory :joe, class: User do
      name 'joe'
    end
  end
end
