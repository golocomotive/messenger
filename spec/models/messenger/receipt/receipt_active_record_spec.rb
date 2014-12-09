require 'rails_helper'

module Messenger
  describe Receipt do
    describe 'Database Columns' do
      specify { should have_db_column(:message_id).of_type(:integer) }
      specify { should have_db_column(:read_at).of_type(:datetime) }
      specify { should have_db_column(:recipient_id).of_type(:integer) }
      specify { should have_db_column(:recipient_type).of_type(:string) }
    end

    describe 'Database Indices' do
      specify { should have_db_index([:message_id]) }
      specify { should have_db_index([:recipient_id, :recipient_type]) }
      specify { should have_db_index([:message_id, :recipient_id, :recipient_type]) }
    end

    describe 'Validations' do
      specify { should validate_presence_of(:message) }
      specify { should validate_presence_of(:recipient) }
      specify { create :receipt; should validate_uniqueness_of(:message).scoped_to(:recipient_id, :recipient_type) }
    end
  end
end
