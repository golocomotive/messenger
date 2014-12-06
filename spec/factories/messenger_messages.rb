FactoryGirl.define do
  factory :messenger_message, :class => 'Messenger::Message' do
    association :sender, factory: :user
    subject     { Faker::Lorem.sentence }
  end
end
