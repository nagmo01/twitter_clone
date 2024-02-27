FactoryBot.define do
  factory :user do
    sequence(:userid) { |n| "test_user#{n}" }
    sequence(:username) { |n| "test_user#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    tel { 99011552244 }
    birthday { 20000101 }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end
end
