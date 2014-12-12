require 'rails_helper'

module Messenger
  describe Membership do
    let!(:g) { create :group_with_members }
    let!(:h) { create :group }

    describe 'Associations' do
      specify { should belong_to :group }
      specify { should belong_to :member }
    end

    describe 'Database Columns' do
      specify { should have_db_column(:group_id).of_type(:integer) }
      specify { should have_db_column(:member_id).of_type(:integer) }
      specify { should have_db_column(:member_type).of_type(:string) }
    end

    describe 'Database Indices' do
      specify { should have_db_index([:group_id]) }
      specify { should have_db_index([:member_type]) }
      specify { should have_db_index([:member_id, :member_type]) }
    end

    describe 'Validations' do
      specify 'precludes a group from being a member of a group' do
        expect { g.memberships.create(member: h) }.to_not change{ described_class.count }
      end

      specify { should validate_presence_of :group }
      specify { should validate_presence_of :member }

      specify 'validate uniqueness of member ID and member type' do
        should validate_uniqueness_of(:member_id).scoped_to(:member_type)
      end
    end
  end
end
