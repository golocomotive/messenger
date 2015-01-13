require 'rails_helper'

module Messenger
  describe Receipt do
    describe 'Scopes' do
      context '.unread' do
        specify { expect(described_class.unread.to_sql)
          .to include('WHERE "messenger_receipts"."read_at" IS NULL') }
      end
    end
  end
end
