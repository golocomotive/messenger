FactoryGirl.define do
  factory :messenger_group, class: 'Messenger::Group', aliases: [:group] do
    name        { generate :random_name }
    association :owner, factory: :user
  end

  factory :group_with_members, class: 'Messenger::Group' do
    name        { generate :random_name }
    association :owner, factory: :user

    after(:build) do |me|
      me.memberships = build_list :membership, 3, group: me
    end
  end
end
