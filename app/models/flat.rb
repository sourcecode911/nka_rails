class Flat < ApplicationRecord
  belongs_to :user
  has_many :residents

  scope :by_user, lambda { |user_id| where(user_id: user_id) }
end
