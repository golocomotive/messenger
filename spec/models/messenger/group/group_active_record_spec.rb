require 'rails_helper'

module Messenger
  describe Group do
    describe 'Associations' do
      specify { should belong_to(:owner) }

      describe ':memberships' do
        let(:g) { create :group }
        let(:u) { create :user }

        specify { should have_many(:memberships) }

        specify 'prohibits the same member from appearing twice' do
          g.memberships.create(member: u)
          g.memberships.create(member: u)
          expect(g.memberships.count).to eq(1)
        end
      end
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
