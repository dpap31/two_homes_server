FactoryGirl.define do
  factory :conversation do
    sender_id 1
    recipient_id 2
    code "123-321"
    password_digest "P@ssw0rd"
  end
end
