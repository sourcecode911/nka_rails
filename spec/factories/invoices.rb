FactoryGirl.define do
  factory :invoice do
    user_id Faker::Number::number(7)
    year Faker::Number::between(2000, 2020)
    state 1
  end
end
