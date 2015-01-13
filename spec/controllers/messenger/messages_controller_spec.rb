require 'rails_helper'

module Messenger
  RSpec.describe MessagesController, :type => :controller do
    routes { Messenger::Engine.routes }

    describe 'Controller Actions' do
      let(:body)       { Faker::Lorem.sentences(2).join(' ') }
      let!(:u)         { User.where(name: 'Joe').first_or_create! }
      let!(:v)         { create :user }
      let!(:messages)  { create_list :message, 3, recipients: [u], sender: v }

      controller do
        def current_user
          @current_user ||= User.where(name: 'Joe').first_or_create!
        end
      end

      specify '#create' do
        post :create, message: { receivers: [ { class: 'User', id: v.id } ], subject: 'Test', body: body }
        expect(u.reload.sent_messages.count).to eq(1)
        expect(v.reload.messages.count).to eq(1)
        expect(v.reload.sent_messages.count).to eq(3)
        expect(u.sent_messages.first.encoded_recipients).to_not be_blank
      end

      specify '#delete' do
        expect { delete :destroy, id: messages.last }.to change{ Receipt.count }.by(-1)
        expect(u.reload.messages.size).to eq(2)
        expect(v.sent_messages.size).to eq(3)
      end

      specify '#index' do
        get :index
        expect(assigns[:messages]).to include(*messages)
      end

      describe '#new' do
        specify 'sends a new message to the form' do
          get :new
          expect(assigns[:message]).to be_a_new(Message)
        end

        specify 'sets the recipient of the message from the params' do
          get :new, message: { recipients: {class: 'User', id: 1} }
          expect(assigns[:recipients]).to_not be_nil
          expect(assigns[:recipients][:class]).to eq('User')
          expect(assigns[:recipients][:id]).to eq('1')
        end
      end

      specify '#show' do
        get :show, id: messages.first
        expect(assigns[:message]).to eq(messages.first)
      end
    end
  end
end
