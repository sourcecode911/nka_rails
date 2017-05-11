FactoryGirl.define do
  factory :invoice_detail do
    invoice_id 1
    expense_id 1
    resident_id 1
    amount "9.99"
    state 1
  end
end
