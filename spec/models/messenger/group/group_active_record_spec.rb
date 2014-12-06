require 'rails_helper'

module Messenger
  describe Group do
    describe 'Associations' do
      specify { should belong_to(:owner) }
      specify { should have_many(:memberships) }
      specify { should have_many(:members).through(:memberships) }
    end

    describe 'Database Columns' do
      specify { should have_db_column(:created_at).of_type(:datetime) }
      specify { should have_db_column(:name).of_type(:string) }
      specify { should have_db_column(:owner_id).of_type(:integer) }
      specify { should have_db_column(:owner_type).of_type(:string) }
      specify { should have_db_column(:updated_at).of_type(:datetime) }
    end

    describe 'Database Indices' do
      specify { should have_db_index([:name]) }
      specify { should have_db_index([:owner_id, :owner_type]) }
      specify { should have_db_index([:name, :owner_id, :owner_type]).unique(true) }
    end

    describe 'Validations' do
      specify { should validate_presence_of :name }
    end
  end
end
