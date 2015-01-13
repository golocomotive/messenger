require 'spec_helper'

module Messenger
  describe Message do
    describe 'Scopes' do
      describe '.draft' do
        specify { expect(described_class.draft.to_sql)
          .to include('WHERE "messenger_messages"."sent_at" IS NULL') }
      end

      describe '.sent' do
        specify { expect(described_class.sent.to_sql)
          .to include('WHERE ("messenger_messages"."sent_at" IS NOT NULL)') }
      end

      describe '.unread' do
        specify { expect(described_class.unread.to_sql)
          .to include('WHERE "messenger_receipts"."read_at" IS NULL') }
      end
    end
  end
end
