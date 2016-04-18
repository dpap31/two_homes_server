require 'rails_helper'

RSpec.describe Invite, type: :model do
  context 'relationships' do
     it { is_expected.to belong_to(:parenting_group) }
     it { is_expected.to belong_to(:sender) }
     it { is_expected.to belong_to(:recipient) }
   end

  context 'Factory is valid' do
    it { expect(FactoryGirl.create(:invite)).to be_truthy }
  end
end
