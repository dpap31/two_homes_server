require 'rails_helper'

RSpec.describe Membership, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:parenting_group) }
  end

  context 'Factory is valid' do
    it { expect(FactoryGirl.create(:membership)).to be_truthy }
  end
end
