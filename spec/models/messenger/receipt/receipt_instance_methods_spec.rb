require 'rails_helper'

module Messenger
  describe Receipt do
    let(:r) { build :receipt }

    describe 'Instance Methods' do
      describe '#sender' do
        specify 'delegates to message' do
          expect(r.sender).to eq(r.message.sender)
        end
      end
    end
  end
end
