FactoryGirl.define do
  factory :conversation do
    sequence(:code) { |n| "123-32#{n}" }
    password_digest "P@ssw0rd"
  end
end
