FactoryGirl.define do
  factory :messenger_message, :class => 'Messenger::Message', aliases: [:message] do
    association :sender, factory: :user
    subject     { Faker::Lorem.sentence }
  end
end
