require 'rails_helper'

RSpec.describe User do
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
