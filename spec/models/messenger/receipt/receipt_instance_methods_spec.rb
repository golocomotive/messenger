require 'rails_helper'

module Messenger
  describe Receipt do
    let(:r) { build :receipt }

    describe 'Instance Methods' do
      describe '#read!' do
        specify 'stamps the read_at field with the time' do
          expect(r).to receive(:touch).with(:read_at)
          r.read!
        end
      end

      describe '#sender' do
        specify 'delegates to message' do
          expect(r.sender).to eq(r.message.sender)
        end
      end

      describe 'unread!' do
        specify 'sets the read_at stamp to nil' do
          expect(r).to receive(:update_column).with(:read_at, nil)
          r.unread!
        end
      end
    end
  end
end
