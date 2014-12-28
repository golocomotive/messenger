require 'spec_helper'

module Services
  describe MessagesControllerCreate do
    let(:u)      { create :user }
    let(:v)      { create :user }
    let(:s)      { create :user }

    let(:params) { {
      message: {
        body:     Faker::Lorem.sentences.join(''),
        subject:  Faker::Lorem.words(3).join(' '),
        receivers: [
          { class: 'User', id: u.id },
          { class: 'User', id: v.id } ] } } }

    subject { described_class.new sender: s, params: params[:message] }

    specify 'message is sent to the recipients' do
      expect { subject.run }.to change{Messenger::Receipt.count}.by(2)
      expect(u.messages.count).to eq(1)
      expect(v.messages.count).to eq(1)
      expect(s.sent_messages.count).to eq(1)
    end
  end
end