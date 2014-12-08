FactoryGirl.define do
  factory :messenger_group, :class => 'Messenger::Group', aliases: [:group] do
    name        { Faker::Lorem.words(3).join }
    association :owner, factory: :user
  end
end
