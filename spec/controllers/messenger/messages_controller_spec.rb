require 'rails_helper'

module Messenger
  RSpec.describe MessagesController, :type => :controller do
    routes { Messenger::Engine.routes }

    describe 'Controller Actions' do
      let(:r)  { User.where(name: 'Joe').first_or_create! }
      let(:s)  { create :user }
      let!(:m) { create_list :message, 3, recipients: [r], sender: s }


      controller do
        def current_user
          @current_user ||= User.where(name: 'Joe').first_or_create!
        end
      end

      specify '#create' do
        post :create, message: { sender_id: }
      end

      specify '#delete' do
        expect { delete :destroy, id: m.last }.to change{ Receipt.count }.by(-1)
        expect(r.reload.messages.size).to eq(2)
        expect(s.sent_messages.size).to eq(3)
      end

      specify '#index' do
        get :index
        expect(assigns[:messages]).to include(*m)
      end

      specify '#new' do
        get :new
        expect(assigns[:message]).to be_a_new(Message)
      end

      specify '#show' do
        get :show, id: m.first
        expect(assigns[:message]).to eq(m.first)
      end
    end
  end
end
