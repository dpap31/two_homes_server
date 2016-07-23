FactoryGirl.define do
  factory :invite do
    sequence(:email) { |n| "#{n}-test@twohomes.com" }
    accepted false
    parenting_group
    sender
    recipient
  end
end
