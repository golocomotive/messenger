require 'rails_helper'

module Util
  describe EncodeDecodeClasses do
    describe 'Instance Methods' do
      let(:g)         { double 'receipt', recipient_id: 1, recipient_type: 'Messenger::Group' }
      let(:u)         { double 'receipt', recipient_id: 2, recipient_type: 'User' }
      let(:encoding)  { 'messenger/group=1&user=2'}

      subject { described_class.encode [g, u] }

      describe '#decode' do
        let(:gid)     { 1 }
        let(:uid)     { 2 }
        let(:vid)     { 3 }
        let(:arg)     { "messenger/group=#{gid}&user=#{uid},#{vid}" }

        specify 'looks up groups and users by ID' do
          expect(Messenger::Group).to receive(:where)
          expect(User).to receive(:where)
          described_class.decode(arg)
        end

        specify 'returns empty array if string is blank' do
          expect(described_class.decode nil).to be_empty
        end
      end

      describe '#encode' do
        specify { expect(subject).to eql(encoding) }
      end

      describe '#missing' do
        specify 'returns missing models' do
          d = described_class.new encoding
          allow(d).to receive(:lookup) { { User => [double(id: 2)], Messenger::Group => [] } }
          expect(d.missing).to eq({ Messenger::Group => [1] })
        end
      end
    end
  end
end
