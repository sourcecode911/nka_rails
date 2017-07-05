class Meter < ApplicationRecord
  belongs_to :flat, optional: true
  belongs_to :parent, class_name: 'Meter', optional: true
  has_many :counts
  accepts_nested_attributes_for :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom, :gas, :warmwasser_gesamt]
  validates_presence_of :initial_count, :expense_type

  scope :by_user, lambda {|user_id| where(user_id: user_id)}

  def count_at(date)
    counts.where(date: date).sum {|c| c[:amount]}
  end

  def find_or_initialize_counts(invoice_id)
    if counts.length == 0
      return Array.new.push(counts.find_or_initialize_by(meter_id: id, invoice_id: invoice_id))
    end
    counts.where(invoice_id: invoice_id)
  end
end
