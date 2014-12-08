FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "User#{n}@example.com"}
    password "password"
    password_confirmation "password"

    trait :admin do
      admin true
    end
  end
end
