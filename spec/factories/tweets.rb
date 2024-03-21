# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    sequence(:content) { |n| "tweet_content#{n}" }
    association :user
  end
end
