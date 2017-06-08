class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :counts, dependent: :destroy

  validates_presence_of :user_id, :year, :state
  validates_uniqueness_of :year, scope: :user_id

end
