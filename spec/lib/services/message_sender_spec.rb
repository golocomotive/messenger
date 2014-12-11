require 'rails_helper'

module Services
  describe MessageSender do
    let(:m)  { create :message }
    let(:u)  { create :user }
    let(:v)  { create :user }

    subject { described_class.new message: m, recipients: [u, v] }

    describe 'Instance Methods' do
      describe '#deliver' do
        specify 'add the message to each recipient' do
          subject.deliver
          expect(u.reload.messages).to include(m)
          expect(v.reload.messages).to include(m)
        end

        specify 'ensure the message is tied to all recipients' do
          subject.deliver
          expect(m.recipients).to include(u, v)
        end

        specify 'sends the message to everyone within the group' do
        end
      end

      describe '#deliver_in_batches' do
        specify 'sends the message to each recipient' do
          subject.deliver_in_batches
          expect(u.reload.messages).to include(m)
          expect(v.reload.messages).to include(m)
        end
      end
    end
  end
end
