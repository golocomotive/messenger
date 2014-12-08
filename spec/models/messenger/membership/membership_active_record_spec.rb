require 'rails_helper'

module Messenger
  describe Membership do
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
  end
end
