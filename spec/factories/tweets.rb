FactoryBot.define do
  factory :tweet do
    sequence(:content) { |n| "tweet_content#{n}" }
    association :user
  end
end
