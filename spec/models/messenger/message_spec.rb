require 'rails_helper'

module Messenger
  RSpec.describe Message, type: :model do
    describe 'Database Columns' do
      specify { should have_db_column(:body).of_type(:text) }
      specify { should have_db_column(:read_at).of_type(:datetime) }
    end

    describe 'Database Indices' do
    end
  end
end
