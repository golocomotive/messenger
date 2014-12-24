require 'rails_helper'

module Messenger
  RSpec.describe MessagesController, :type => :controller do
    routes { Messenger::Engine.routes }

    describe 'Controller Actions' do
      let(:s) { create :user }
      let(:r) { create :user }

      controller do
        def current_user
          @current_user ||= FactoryGirl.create :user
        end
      end

      specify '(verify spec setup)' do
        m = create_list :message, 3, recipients: [r], sender: controller.current_user
        expect(r.messages).to include(*m)
      end

      specify '#delete' do
        m = create_list :message, 3, recipients: [r], sender: controller.current_user
        expect { delete :destroy, id: m.last }.to change{ Message.count }.by(-1)
      end
    end
  end
end
