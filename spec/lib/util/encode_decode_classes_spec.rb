require 'rails_helper'

module Util
  describe EncodeDecodeClasses do
    describe 'Instance Methods' do
      let(:g) { double 'receipt', recipient_id: 1, recipient_type: 'Group' }
      let(:u) { double 'receipt', recipient_id: 2, recipient_type: 'User' }

      describe '#encode' do
        specify { expect(described_class.new(g, u).encode).to eql('group=1&user=2') }
      end

      describe '#decode' do
        let(:gid) { 1 }
        let(:uid) { 2 }
        let(:vid) { 3 }
        let(:arg) { "messenger/group=#{gid}&user=#{uid},#{vid}" }

        specify 'looks up groups and users by ID' do
          expect(Messenger::Group).to receive(:where)
          expect(User).to receive(:where)
          described_class.decode(arg)
        end
      end
    end
  end
end
