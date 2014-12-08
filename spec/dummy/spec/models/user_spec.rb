require 'rails_helper'

describe User do
  describe 'Associations' do
    specify { should have_many(:groups).through(:memberships) }
    specify { should have_many :memberships }
  end
end
