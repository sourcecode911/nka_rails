class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy

  validates_presence_of :user_id, :year, :state
end
