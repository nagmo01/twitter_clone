# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:userid) { |n| "test_user#{n}" }
    sequence(:username) { |n| "test_user#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    tel { 99_011_552_244 }
    birthday { 20_000_101 }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.today }
  end
end
