class Meter < ApplicationRecord
  belongs_to :flat, optional: true
  belongs_to :parent, class_name: 'Meter', optional: true
  has_many :counts
  accepts_nested_attributes_for :counts

  enum expense_type: [:kaltwasser, :warmwasser, :heizung, :strom, :gas, :warmwasser_gesamt]
  validates_presence_of :initial_count, :expense_type

  scope :by_user, lambda {|user_id| where(user_id: user_id)}

  def self.total_count_sum(expense_type, invoice)
    Meter.where(expense_type: expense_type).sum do |m|
      m.counts.where(invoice_id: invoice.id).sum {|c| c[:amount]}
    end
  end

  def self.initial_count_sum(expense_type, user_id)
    Meter.where(expense_type: expense_type, user_id: user_id).sum {|m| m[:initial_count]}
  end

  def self.get_total_usage(expense_type, invoice)
    prev_invoice = Invoice.where(year: (invoice.year - 1)).first
    if prev_invoice.nil?
      old_count = Meter.initial_count_sum(expense_type, invoice.user_id)
    else
      old_count = Meter.total_count_sum(expense_type, prev_invoice)
    end
    total_verbrauch = Meter.total_count_sum(expense_type, invoice) - old_count
    return total_verbrauch
  end

  def self.get_flat_usage(expense_type, invoice, flat_id)
    prev_invoice = Invoice.where(year: (invoice.year - 1)).first
    if prev_invoice.nil?
      old_count = Meter.where(expense_type: expense_type, user_id: invoice.user_id, flat_id: flat_id).sum {|m| m[:initial_count]}
    else
      old_count = Meter.where(expense_type: expense_type, flat_id: flat_id).sum { |m| m.counts.where(invoice_id: prev_invoice.id).sum {|c| c[:amount]}}
    end
    current_count = Meter.where(expense_type: expense_type, flat_id: flat_id).sum { |m| m.counts.where(invoice_id: invoice.id).sum {|c| c[:amount]}}
    flat_usage = current_count - old_count
    return flat_usage
  end

  def self.get_share(invoice, flat_id, expense_type)
    gesamt_verbrauch = Meter.get_total_usage(expense_type, invoice)
    verbrauch = Meter.get_flat_usage(expense_type, invoice, flat_id)
    return (verbrauch/gesamt_verbrauch)
  end

  def find_or_initialize_counts(invoice_id)
    if counts.length == 0
      return Array.new.push(counts.find_or_initialize_by(meter_id: id, invoice_id: invoice_id))
    end
    counts.where(invoice_id: invoice_id)
  end

  def self.warmwasser_share(invoice)
    gesamt = Meter.get_total_usage(:heizung, invoice) + Meter.get_total_usage(:warmwasser_gesamt, invoice)
    warmwasser = Meter.get_total_usage(:warmwasser_gesamt, invoice)
    return (warmwasser/gesamt)
  end

  def self.heizungs_share(invoice)
    gesamt = Meter.get_total_usage(:heizung, invoice) + Meter.get_total_usage(:warmwasser_gesamt, invoice)
    heizung = Meter.get_total_usage(:heizung, invoice)
    return (heizung/gesamt)
  end
end
