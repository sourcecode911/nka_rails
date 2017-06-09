class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :counts
  belongs_to :user
  has_many :flats, through: :user

  validates_presence_of :user_id, :year, :state
  validates_uniqueness_of :year, scope: :user_id

  accepts_nested_attributes_for :flats

end
