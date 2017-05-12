FactoryGirl.define do
  factory :invoice_detail do
    invoice_id nil
    expense_id nil
    resident_id nil
    amount { Faker::Number::decimal(2,2) }
    state 1
  end
end
