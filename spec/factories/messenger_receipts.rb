FactoryGirl.define do
  factory :messenger_receipt, :class => 'Messenger::Receipt', aliases: [:receipt] do
    association :message
    association :recipient, factory: :user
  end
end
