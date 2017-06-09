class Meter < ApplicationRecord
  belongs_to :flat
  belongs_to :parent, class_name: 'Meter'
  has_many :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom]

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

  accepts_nested_attributes_for :counts
end
