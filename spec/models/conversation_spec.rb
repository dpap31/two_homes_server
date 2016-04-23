require 'rails_helper'

RSpec.describe Conversation do

  context 'relationships' do
    it { is_expected.to have_many(:user_conversations) }
    it { is_expected.to belong_to(:parenting_group) }
    it { is_expected.to have_many(:users).through(:user_conversations) }
  end

  context 'validations' do
    it { is_expected.to have_attribute  'name'}
  end
end
