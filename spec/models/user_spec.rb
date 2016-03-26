require 'rails_helper'

RSpec.describe User do
  ["first_name", "last_name", "email", "persona"].each do |required_attr|
    it { is_expected.to have_attribute required_attr }
    it { is_expected.to validate_presence_of required_attr }
  end
  it "validates uniqueness of email attribute" do
    original = FactoryGirl.create(:user)
    dup = FactoryGirl.build(:user, email: original.email)
    expect{dup.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
