require 'rails_helper'

RSpec.describe InvoiceDetail, type: :model do
  it { should belong_to(:invoice) }

  it { should validate_presence_of(:invoice_id) }
  it { should validate_presence_of(:expense_id) }
  it { should validate_presence_of(:resident_id) }
  it { should validate_presence_of(:state) }
end
