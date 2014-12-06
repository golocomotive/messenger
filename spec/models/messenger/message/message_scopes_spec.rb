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
    end
  end
end
