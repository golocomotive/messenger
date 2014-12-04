FactoryGirl.define do
  factory :messenger_message, :class => 'Messenger::Message' do
    body "MyText"
read_at "2014-12-04 09:37:13"
sender nil
  end

end
