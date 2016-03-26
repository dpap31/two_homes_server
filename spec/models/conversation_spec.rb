require 'rails_helper'

RSpec.describe Conversation do
  ['sender_id', 'recipient_id', 'code'].each do |required_attr|
    it { is_expected.to have_attribute required_attr }
    it { is_expected.to validate_presence_of required_attr }
  end

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

  [:sender, :recipient].each do |owner|
    it 'validates conversation belongs to sender and recipient' do
      conversation = FactoryGirl.create(:conversation)
      expect(conversation).to belong_to(owner).class_name('User')
    end
  end

  context 'check for conversations between users' do
    let(:sender) { FactoryGirl.create(:user) }
    let(:recipient) { FactoryGirl.create(:user) }
    let!(:conversation) { FactoryGirl.create(:conversation, sender: sender, recipient: recipient) }
    it 'confirms conversation between sender and reciever exisits' do
      expect(Conversation.between(sender.id, recipient.id).present?).to eq(true)
      expect(Conversation.between(recipient.id, sender.id).present?).to eq(true)
    end
    it 'confirms conversation between users self does not exist' do
      expect(Conversation.between(sender.id, sender.id).present?).to eq(false)
      expect(Conversation.between(recipient.id, recipient.id).present?).to eq(false)
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
