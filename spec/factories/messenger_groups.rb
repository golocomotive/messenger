FactoryGirl.define do
  factory :messenger_group, :class => 'Messenger::Group', aliases: [:group] do
    name        { Faker::Lorem.words(3).join }
    association :owner, factory: :user

    factory :group_with_members do
      after(:build) do |me|
        me.memberships = build_list :membership, 3
      end
    end
  end
end
