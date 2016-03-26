FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@twohomes.com" }
    first_name "Drew"
    last_name "Pappas"
    persona 1
  end
end
