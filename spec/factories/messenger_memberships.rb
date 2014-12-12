FactoryGirl.define do
  factory :messenger_membership, :class => 'Messenger::Membership', aliases: [:membership] do
    association :group
    association :member, factory: :user
  end
end
