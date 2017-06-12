class Meter < ApplicationRecord
  belongs_to :flat
  belongs_to :parent, class_name: 'Meter', optional: true
  has_many :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom, :gas, :warmwasser_gesamt]

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

  accepts_nested_attributes_for :counts

  def self.get_count_sum(expense_type, invoice_id)
    Meter.where(expense_type: expense_type).sum {|m| m.counts.where(invoice_id: invoice_id).sum {|c| c[:amount]}}
  end

  def self.get_flat_count_sum(expense_type, invoice_id, flat_id)
    Meter.where(expense_type: expense_type, flat_id: flat_id).sum {|m| m.counts.where(invoice_id: invoice_id).sum {|c| c[:amount]}}
end

  def self.get_share(invoice, flat, expense_type)
    gesamt_verbrauch = Meter.get_count_sum(expense_type, invoice.id)
    verbrauch = Meter.get_flat_count_sum(expense_type, invoice.id, flat.id)
    return (verbrauch/gesamt_verbrauch)
  end

  def find_or_initialize_counts(invoice_id)
    if counts.length == 0
      return Array.new.push(counts.find_or_initialize_by(meter_id: id, invoice_id: invoice_id))
    end
    counts.where(invoice_id: invoice_id)
  end

  def self.warmwasser_share(invoice_id)
    gesamt = Meter.get_count_sum(:heizung, invoice_id) + Meter.get_count_sum(:warmwasser_gesamt, invoice_id)
    warmwasser = Meter.get_count_sum(:warmwasser_gesamt, invoice_id);
    return (warmwasser/gesamt)
  end

  def self.heizungs_share(invoice_id)
    gesamt = Meter.get_count_sum(:heizung, invoice_id) + Meter.get_count_sum(:warmwasser_gesamt, invoice_id)
    heizung = Meter.get_count_sum(:heizung, invoice_id);
    return (heizung/gesamt)
  end
end
