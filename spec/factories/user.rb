FactoryBot.define do
  factory :user do
    telegram_id { rand(1000000) }
    sex { %w[male female other].shuffle.first }

    trait :with_age do
      age { rand(99) }
    end
  end
end
