require 'rails_helper'

RSpec.describe User do

  context 'relationships' do
    it { is_expected.to have_many(:user_conversations) }
    it { is_expected.to have_many(:conversations).through(:user_conversations) }
  end

  context 'validations' do

    ['first_name', 'last_name', 'email', 'persona'].each do |required_attr|
      it { is_expected.to have_attribute required_attr }
      it { is_expected.to validate_presence_of required_attr }
    end

    it 'expects to have password' do
      is_expected.to validate_presence_of('password')
    end

    it 'validates uniqueness of email attribute' do
      original = FactoryGirl.create(:user)
      dup = FactoryGirl.build(:user, email: original.email)
      expect{dup.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'persists password digest based on the password that can be used for authentication' do
      password = 'password'
      subject = FactoryGirl.create(:user, password: password)
      expect(subject.authenticate(password)).to eq(subject)
    end
  end

  context 'callbacks' do

    subject { FactoryGirl.create(:user, first_name: 'drew', last_name: 'pappas') }
    it 'persists initials attribute on save' do
      expect(subject.initials).to eq('DP')
    end

    it 'updates initials attribute on update' do
      subject.first_name = 'andrew'
      subject.save!
      expect(subject.initials).to eq('AP')
    end
  end

  context 'parse_initials_from_name' do

    it 'parses and upcases initials' do 
      initials_1 = FactoryGirl.build(:user, first_name: 'drew', last_name: 'pappas').parse_initials_from_name
      expect(initials_1).to eq('DP')
    end

    it 'is only two characters' do
      initials_2 = FactoryGirl.build(:user, first_name: 'drew james', last_name: 'pappas simmons').parse_initials_from_name
      expect(initials_2.length).to eq(2)
    end
  end
end
