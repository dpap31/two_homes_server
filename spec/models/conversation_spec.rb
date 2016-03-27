require 'rails_helper'

RSpec.describe Conversation do

  context 'relationships' do
    it { is_expected.to have_many(:user_conversations) }
    it { is_expected.to have_many(:users).through(:user_conversations) }
  end

  context 'validations' do
    it { is_expected.to have_attribute  'code'}
    it { is_expected.to validate_presence_of 'code' }

    it 'validates uniqueness of conversation code' do
      original = FactoryGirl.create(:conversation)
      dup = FactoryGirl.build(:conversation, code: original.code)
      expect{dup.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'persists password digest based on the password that can be used for authentication' do
      password = 'password'
      subject = FactoryGirl.create(:conversation, password: password)
      expect(subject.authenticate(password)).to eq(subject)
    end
  end

  context 'conversation code generation' do
    let(:code) { FactoryGirl.create(:conversation).generate_code }
    it 'should have 7 characters' do
      expect(code.length).to eq(7)
    end
    it 'should have a dash as the 4th character' do
      expect(code[3]).to eq('-')
    end
  end
end
