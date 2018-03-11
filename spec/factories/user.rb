FactoryBot.define do
  factory :user do
    phone_number { Ryba::PhoneNumber.phone_number }
    sex { %w[male female other].shuffle.first }
    age { rand(99) }
  end
end
