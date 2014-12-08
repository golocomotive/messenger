require 'rails_helper'

module Messenger
  describe Group do
    describe 'Validations' do
      specify { should validate_presence_of :name }
      specify { should validate_presence_of :owner }
    end
  end
end
