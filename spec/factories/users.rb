FactoryGirl.define do
  factory :user, aliases: [:sender, :recipient] do
    sequence(:email) { |n| "test-#{n}@twohomes.com" }
    first_name "Drew"
    last_name "Pappas"
    persona 1
    password "12345"
  end
end
