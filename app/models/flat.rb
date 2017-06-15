class Flat < ApplicationRecord
  belongs_to :user
  has_many :meters
  has_many :residents
  accepts_nested_attributes_for :meters

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

end
