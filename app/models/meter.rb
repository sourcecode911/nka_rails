class Meter < ApplicationRecord
  belongs_to :flat
  belongs_to :parent, class_name: 'Meter', optional: true
  has_many :counts
  accepts_nested_attributes_for :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom, :gas, :warmwasser_gesamt]
  validates_presence_of :initial_count, :expense_type, :flat_id

  scope :by_user, lambda { |user_id| where(user_id: user_id) }

  def self.get_count_sum(expense_type, invoice)
    Meter.where(expense_type: expense_type).sum {|m| m.counts.where(invoice_id: invoice.id).sum {|c| c[:amount]}}
  end

  def self.get_flat_count_sum(expense_type, invoice, flat_id)
    prev_invoice = Invoice.where(year: (invoice.year - 1))
    old_sum = Meter.where(expense_type: expense_type, flat_id: flat_id).sum do |m|
      counts = m.counts.where(invoice_id: prev_invoice.id)
      if counts.length == 0
        return m.initial_count
      else
        return counts.sum {|c| c[:amount]}
      end
    end
    new_sum = Meter.where(expense_type: expense_type, flat_id: flat_id).sum {|m| m.counts.where(invoice_id: invoice.id).sum {|c| c[:amount]}}
    return (new_sum - old_sum)
  end

  def self.get_share(invoice, flat, expense_type)
    gesamt_verbrauch = Meter.get_count_sum(expense_type, invoice)
    verbrauch = Meter.get_flat_count_sum(expense_type, invoice, flat.id)
    return (verbrauch/gesamt_verbrauch)
  end

  def find_or_initialize_counts(invoice_id)
    if counts.length == 0
      return Array.new.push(counts.find_or_initialize_by(meter_id: id, invoice_id: invoice_id))
    end
    counts.where(invoice_id: invoice_id)
  end

  def self.warmwasser_share(invoice)
    gesamt = Meter.get_count_sum(:heizung, invoice) + Meter.get_count_sum(:warmwasser_gesamt, invoice)
    warmwasser = Meter.get_count_sum(:warmwasser_gesamt, invoice);
    return (warmwasser/gesamt)
  end

  def self.heizungs_share(invoice)
    gesamt = Meter.get_count_sum(:heizung, invoice) + Meter.get_count_sum(:warmwasser_gesamt, invoice)
    heizung = Meter.get_count_sum(:heizung, invoice);
    return (heizung/gesamt)
  end
end
