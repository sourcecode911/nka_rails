class Flat < ApplicationRecord
  belongs_to :user
  has_many :residents
  has_many :counts

  accepts_nested_attributes_for :counts
end
