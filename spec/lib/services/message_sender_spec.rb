require 'rails_helper'

module Services
  describe MessageSender do
    let(:g)  { create :group_with_members }
    let(:m)  { create :message }
    let(:u)  { create :user }
    let(:v)  { create :user }

    def received?
      expect(u.reload.messages).to include(m)
      expect(v.reload.messages).to include(m)
    end

    def received_via_group?
      expect(g.members.all? { |member| member.reload.messages.include?(m) }).to be_truthy
    end

    describe 'Instance Methods' do
      describe '#deliver' do
        describe 'to individuals' do
          subject { described_class.new message: m, recipients: [u, v] }

          specify 'sends the message singly' do
            subject.deliver
            received?
          end

          specify 'ties the message to its recipients' do
            subject.deliver
            expect(m.recipients).to include(u, v)
          end
        end

        describe 'to a group' do
          subject { described_class.new message: m, recipients: g }

          specify 'sends the message to everyone within the group' do
            subject.deliver
            received_via_group?
          end
        end

        describe 'to a mix of recipients' do
          subject { described_class.new message: m, recipients: [u, v, g] }

          specify 'sends the message to all in group or singly' do
            subject.deliver
            received?
            received_via_group?
          end
        end
      end

      describe '#deliver_in_batches' do
        describe 'to individuals' do
          subject { described_class.new message: m, recipients: [u, v] }

          specify 'sends the message singly' do
            subject.deliver_in_batches
            received?
          end
        end

        describe 'to a mix of recipients' do
          subject { described_class.new message: m, recipients: [g, u, v] }

          specify 'sends the message to each individual' do
            subject.deliver_in_batches
            received?
            received_via_group?
          end
        end
      end
    end
  end
end
