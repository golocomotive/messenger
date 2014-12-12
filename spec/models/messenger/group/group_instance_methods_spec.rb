require 'rails_helper'

module Messenger
  describe Group do
    describe 'Instance Methods' do
      describe '.members' do
        let(:o) { create :user }
        let(:u) { create :user }
        let(:v) { create :user }
        let(:g) { create :group, owner: o }

        specify 'finds all members' do
          g.memberships.build(member: u)
          g.memberships.build(member: v)
          g.save!
          expect(g.members).to match([u, v])
        end
      end
    end
  end
end
