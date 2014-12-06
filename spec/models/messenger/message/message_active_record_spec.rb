require 'rails_helper'

module Messenger
  RSpec.describe Message, type: :model do
    describe 'Associations' do
      specify { should belong_to(:sender) }
    end

    describe 'Database Columns' do
      specify { should have_db_column(:body).of_type(:text) }
      specify { should have_db_column(:created_at).of_type(:datetime) }
      specify { should have_db_column(:sender_id).of_type(:integer) }
      specify { should have_db_column(:sender_type).of_type(:string) }
      specify { should have_db_column(:sent_at).of_type(:datetime) }
      specify { should have_db_column(:subject).of_type(:string) }
      specify { should have_db_column(:updated_at).of_type(:datetime) }
    end

    describe 'Database Indices' do
      specify { should have_db_index([:sender_id, :sender_type]) }
    end

    describe 'Validations' do
      specify { should validate_presence_of :sender }
      specify { should validate_presence_of :subject }
    end
  end
end
