class InvoiceDetail < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :expense_id, :invoice_id, :resident_id, :state
end
