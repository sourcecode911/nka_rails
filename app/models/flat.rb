class Flat < ApplicationRecord
  belongs_to :user

  has_many :meters
  has_many :residents

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

  accepts_nested_attributes_for :meters
end
