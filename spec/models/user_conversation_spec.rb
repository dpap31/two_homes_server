require 'rails_helper'

RSpec.describe UserConversation do
  context 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:conversation) }
  end

  context 'validations' do
    ['user_id', 'conversation_id'].each do |required_attr|
      it { is_expected.to have_attribute required_attr }
      it { is_expected.to validate_presence_of required_attr }
    end
  end
end
