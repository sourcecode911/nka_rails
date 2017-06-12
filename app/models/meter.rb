class Meter < ApplicationRecord
  belongs_to :flat
  belongs_to :parent, class_name: 'Meter', optional: true
  has_many :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom]

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

  accepts_nested_attributes_for :counts

  def find_or_initialize_counts
    if counts.length == 0
      return Array.new.push(counts.find_or_initialize_by(meter_id: id))
    end
    counts
  end
end
