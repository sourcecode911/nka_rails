class Meter < ApplicationRecord
  has_many :counts
  belongs_to :flat

  enum expense_type: [:kaltwasser, :warmwasser, :heizung]
end
