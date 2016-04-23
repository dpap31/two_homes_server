require 'rails_helper'

RSpec.describe ParentingGroup, type: :model do
  context 'relationships' do
     it { is_expected.to have_many(:memberships) }
     it { is_expected.to have_many(:invites) }
     it { is_expected.to have_many(:users).through(:memberships) }
     it { is_expected.to have_many(:invites) }
     it { is_expected.to have_many(:conversations) }
   end

  context 'Factory is valid' do
    it { expect(FactoryGirl.create(:parenting_group)).to be_truthy }
  end
end
