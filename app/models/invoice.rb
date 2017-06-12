class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :counts
  belongs_to :user
  has_many :flats, through: :user
  has_many :meters, through: :flats

  validates_presence_of :user_id, :year, :state
  validates_uniqueness_of :year, scope: :user_id

  accepts_nested_attributes_for :flats


  def finalize
    flats.each do |f|
      detail = InvoiceDetail.new
      detail.resident_id = f.residents.first.id
      detail.invoice_id = id
      detail.amount = 0
      detail.amount += wasserkosten(f)
    end
  end

  def wasserkosten(flat)
    wasser_anteil = Meter.get_share(self, flat, 0)
    return (wasser_anteil*wasser)
  end

  def heizungskosten(flat)
    heizkosten = gesamt_heizkosten * Meter.heizungs_share(id)
    heizung_anteil = Meter.get_share(self, flat, 2)
    return (heizkosten*heizung_anteil)
  end

  def warmwasserkosten(flat)
    warmwasser_kosten = gesamt_heizkosten * Meter.warmwasser_share(id)
    warmwasser_anteil = Meter.get_share(self, flat, 1)
    return (warmwasser_kosten*warmwasser_anteil)
  end

  def gesamt_heizkosten
    erdgas + kamin + wartung + reinigung
  end

end
