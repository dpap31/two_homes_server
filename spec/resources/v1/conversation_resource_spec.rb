module V1
  RSpec.describe ConversationResource do

    let :creatable_fields do
      [:id, :code, :password].sort
    end

    subject do
      described_class.new(Conversation.new, {})
    end

    it 'has the expected creatable_attributes' do
      expect(described_class.creatable_fields({}).sort).to eq(creatable_fields)
    end

    it 'has the expected updateable_attributes' do
      expect(described_class.updatable_fields({}).sort).to eq(creatable_fields)
    end

    it "has the expected fetchable attributes" do
      expect(subject.fetchable_fields.sort).to eq ((creatable_fields + [:created_at, :updated_at, :user_conversations, :users] - [:password]).sort)
    end
  end
end
