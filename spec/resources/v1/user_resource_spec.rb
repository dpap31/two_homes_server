module V1
  RSpec.describe UserResource do

    let :creatable_fields do
      [:id, :email, :first_name, :last_name, :persona, :password, :conversations, :parenting_groups ].sort
    end

    subject do
      described_class.new(User.new, {})
    end

    it 'has the expected creatable_attributes' do
      expect(described_class.creatable_fields({}).sort).to eq(creatable_fields)
    end

    it 'has the expected updateable_attributes' do
      expect(described_class.updatable_fields({}).sort).to eq(creatable_fields)
    end

    it "has the expected fetchable attributes" do
      fetachable_attrs = [:created_at, :updated_at, :user_conversations, :full_name, :initials, :memberships, :invitations,]
      expect(subject.fetchable_fields.sort).to eq ((creatable_fields + fetachable_attrs - [:password]).sort)
    end
  end
end
