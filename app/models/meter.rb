class Meter < ApplicationRecord
  belongs_to :flat
  has_many :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom]
end
