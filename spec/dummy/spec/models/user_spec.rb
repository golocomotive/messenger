require 'rails_helper'

describe User do
  describe 'Associations' do
    specify { should have_many(:groups).through(:memberships) }
    specify { should have_many :memberships }
    specify { should have_many :receipts }
    specify { should have_many(:messages).through(:receipts) }
    specify { should have_many(:sent_messages) }
  end

  describe 'Validations' do
    specify { should validate_presence_of :name }
    specify { create :user; should validate_uniqueness_of :name }
  end
end
