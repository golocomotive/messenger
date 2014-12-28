FactoryGirl.define do
  factory :messenger_message, :class => 'Messenger::Message', aliases: [:message] do
    body        { Faker::Lorem.sentences(3).join }
    association :sender, factory: :user
    subject     { Faker::Lorem.sentence }
  end
end
