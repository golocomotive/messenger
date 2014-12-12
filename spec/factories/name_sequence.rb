FactoryGirl.define do
  sequence :random_name do |n|
    Faker::Lorem.words(3).join
  end
end
