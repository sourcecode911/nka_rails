class InvoiceDetail < ApplicationRecord
  belongs_to :invoice
  belongs_to :resident

  validates_presence_of :invoice_id, :resident_id, :state
end
