FactoryGirl.define do
  factory :messenger_group, :class => 'Messenger::Group' do
    name { Faker::Lorem.words(3).join }
  end
end
